import 'dart:async';
import 'package:flutter/material.dart' hide Chip;
import 'package:google_fonts/google_fonts.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import '../../data/workout_models.dart';

class TrainingActive extends StatefulWidget {
  final void Function(String) push;
  const TrainingActive({super.key, required this.push});

  @override
  State<TrainingActive> createState() => _TrainingActiveState();
}

class _TrainingActiveState extends State<TrainingActive> {
  late List<ActiveExercise> _exercises;

  // Session timer
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _sessionTick;
  String _sessionTime = '00:00';

  // Rest timer
  int _restDuration = 90; // default seconds
  int _restRemaining = 0;
  Timer? _restTick;
  bool _showRestSheet = false;

  @override
  void initState() {
    super.initState();
    _exercises = createMockRoutine();
    _stopwatch.start();
    _sessionTick = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      final elapsed = _stopwatch.elapsed;
      setState(() {
        _sessionTime =
            '${elapsed.inMinutes.toString().padLeft(2, '0')}:${(elapsed.inSeconds % 60).toString().padLeft(2, '0')}';
      });
    });
  }

  @override
  void dispose() {
    _sessionTick?.cancel();
    _restTick?.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  // --- Progress ---
  int get _totalSets => _exercises.fold(0, (sum, ex) => sum + ex.sets.length);
  int get _completedSets =>
      _exercises.fold(0, (sum, ex) => sum + ex.completedSets);
  double get _progress => _totalSets == 0 ? 0 : _completedSets / _totalSets;

  // --- Rest Timer ---
  void _startRestTimer() {
    _restTick?.cancel();
    setState(() {
      _restRemaining = _restDuration;
      _showRestSheet = true;
    });
    _restTick = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {
        _restRemaining--;
        if (_restRemaining <= 0) {
          _dismissRest();
        }
      });
    });
  }

  void _dismissRest() {
    _restTick?.cancel();
    if (mounted) {
      setState(() {
        _showRestSheet = false;
        _restRemaining = 0;
      });
    }
  }

  void _adjustRest(int delta) {
    setState(() {
      _restRemaining = (_restRemaining + delta).clamp(0, 600);
    });
  }

  // --- Set completed ---
  void _onSetCompleted(int exerciseIdx, int setIdx, bool value) {
    setState(() {
      _exercises[exerciseIdx].sets[setIdx].completed = value;
    });
    if (value) {
      _startRestTimer();
    }
  }

  // --- Add set ---
  void _addSet(int exerciseIdx) {
    final lastSet = _exercises[exerciseIdx].sets.last;
    setState(() {
      _exercises[exerciseIdx].sets.add(
        WorkoutSet(weight: lastSet.weight, reps: lastSet.reps),
      );
    });
  }

  // --- Add exercise ---
  void _addExercise() {
    setState(() {
      _exercises.add(
        ActiveExercise(
          name: 'Nuevo ejercicio',
          sets: [WorkoutSet(weight: 0, reps: 10)],
        ),
      );
    });
  }

  // --- Finish ---
  void _confirmFinish() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Terminar rutina',
            style: TextStyle(color: AppColors.text)),
        content: Text(
          '$_completedSets de $_totalSets series completadas.\n¿Deseas finalizar?',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child:
                const Text('Cancelar', style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _stopwatch.stop();
              widget.push('terminar');
            },
            child: const Text('Finalizar',
                style: TextStyle(color: AppColors.accent)),
          ),
        ],
      ),
    );
  }

  // --- Abandon ---
  void _confirmAbandon() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('¿Abandonar rutina?',
            style: TextStyle(color: AppColors.text)),
        content: const Text('Se perderá el progreso de esta sesión.',
            style: TextStyle(color: AppColors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child:
                const Text('Continuar', style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _stopwatch.stop();
              // Pop back (the training_screen handles navigation)
              widget.push('lista');
            },
            child: const Text('Abandonar',
                style: TextStyle(color: AppColors.accentRose)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: _confirmAbandon,
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.timer_outlined,
                size: 16, color: AppColors.accent),
            const SizedBox(width: 6),
            Text(
              _sessionTime,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.accent,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.textSecondary),
            onPressed: () => widget.push('opciones'),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Progress bar
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: _progress,
                        backgroundColor: AppColors.surface,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.accent),
                        minHeight: 4,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${(_progress * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
              ),
              // Exercises list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                  itemCount: _exercises.length + 2, // +1 add exercise, +1 finish
                  itemBuilder: (context, index) {
                    if (index < _exercises.length) {
                      return _buildExerciseCard(index);
                    } else if (index == _exercises.length) {
                      return _buildAddExerciseButton();
                    } else {
                      return _buildFinishButton();
                    }
                  },
                ),
              ),
            ],
          ),
          // Rest Timer BottomSheet
          if (_showRestSheet) _buildRestOverlay(),
        ],
      ),
    );
  }

  // ─── EXERCISE CARD ──────────────────────────────────────────

  Widget _buildExerciseCard(int exerciseIdx) {
    final exercise = _exercises[exerciseIdx];
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AppCard(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 8, 0),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.fitness_center,
                        size: 16, color: AppColors.accent),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      exercise.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                  ),
                  // Note toggle
                  IconButton(
                    icon: Icon(
                      exercise.note.isNotEmpty
                          ? Icons.sticky_note_2
                          : Icons.sticky_note_2_outlined,
                      size: 18,
                      color: exercise.note.isNotEmpty
                          ? AppColors.accent
                          : AppColors.textTertiary,
                    ),
                    onPressed: () => _showNoteDialog(exerciseIdx),
                  ),
                ],
              ),
            ),
            // Notes (if any)
            if (exercise.note.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Text(
                  exercise.note,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            // Table header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: const [
                  SizedBox(
                      width: 40,
                      child: Text('SERIE',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textTertiary,
                              letterSpacing: 0.5))),
                  Expanded(
                      child: Center(
                          child: Text('KG',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textTertiary,
                                  letterSpacing: 0.5)))),
                  Expanded(
                      child: Center(
                          child: Text('REPS',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textTertiary,
                                  letterSpacing: 0.5)))),
                  SizedBox(width: 44),
                ],
              ),
            ),
            const SizedBox(height: 4),
            // Set rows
            ...List.generate(exercise.sets.length, (setIdx) {
              return _buildSetRow(exerciseIdx, setIdx);
            }),
            // Add set button
            InkWell(
              onTap: () => _addSet(exerciseIdx),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(color: AppColors.border, width: 0.5)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, size: 16, color: AppColors.accent),
                    SizedBox(width: 4),
                    Text('Añadir serie',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.accent)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── SET ROW ────────────────────────────────────────────────

  Widget _buildSetRow(int exerciseIdx, int setIdx) {
    final set = _exercises[exerciseIdx].sets[setIdx];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: set.completed
            ? AppColors.accent.withOpacity(0.06)
            : Colors.transparent,
        border: const Border(
            bottom: BorderSide(color: AppColors.border, width: 0.3)),
      ),
      child: Row(
        children: [
          // Set number
          SizedBox(
            width: 40,
            child: Text(
              '${setIdx + 1}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: set.completed
                    ? AppColors.accent
                    : AppColors.textSecondary,
              ),
            ),
          ),
          // Weight input
          Expanded(child: _numericField(
            value: set.weight,
            onChanged: (v) {
              setState(() => set.weight = v);
            },
            completed: set.completed,
          )),
          // Reps input
          Expanded(child: _numericField(
            value: set.reps.toDouble(),
            onChanged: (v) {
              setState(() => set.reps = v.toInt());
            },
            completed: set.completed,
            isInt: true,
          )),
          // Checkbox
          SizedBox(
            width: 44,
            child: Center(
              child: GestureDetector(
                onTap: () =>
                    _onSetCompleted(exerciseIdx, setIdx, !set.completed),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: set.completed
                        ? AppColors.accent
                        : Colors.transparent,
                    border: Border.all(
                      color: set.completed
                          ? AppColors.accent
                          : AppColors.border,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: set.completed
                      ? const Icon(Icons.check, size: 18, color: AppColors.bg)
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── NUMERIC INPUT FIELD ────────────────────────────────────

  Widget _numericField({
    required double value,
    required ValueChanged<double> onChanged,
    bool completed = false,
    bool isInt = false,
  }) {
    final controller = TextEditingController(
      text: isInt ? value.toInt().toString() : value.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), ''),
    );
    return Center(
      child: SizedBox(
        width: 60,
        height: 34,
        child: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: completed ? AppColors.accent : AppColors.text,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: completed
                ? AppColors.accent.withOpacity(0.08)
                : AppColors.bg,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: completed ? AppColors.accent.withOpacity(0.3) : AppColors.border,
                width: 0.8,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: completed ? AppColors.accent.withOpacity(0.3) : AppColors.border,
                width: 0.8,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide:
                  const BorderSide(color: AppColors.accent, width: 1.2),
            ),
          ),
          onSubmitted: (text) {
            final parsed = double.tryParse(text);
            if (parsed != null) onChanged(parsed);
          },
          onTapOutside: (_) {
            final parsed = double.tryParse(controller.text);
            if (parsed != null) onChanged(parsed);
            FocusScope.of(context).unfocus();
          },
        ),
      ),
    );
  }

  // ─── NOTE DIALOG ────────────────────────────────────────────

  void _showNoteDialog(int exerciseIdx) {
    final controller =
        TextEditingController(text: _exercises[exerciseIdx].note);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(_exercises[exerciseIdx].name,
            style: const TextStyle(
                color: AppColors.text, fontSize: 16, fontWeight: FontWeight.w700)),
        content: TextField(
          controller: controller,
          maxLines: 3,
          autofocus: true,
          style: const TextStyle(color: AppColors.text, fontSize: 14),
          decoration: const InputDecoration(
            hintText: 'Ej: Sentí dolor en el hombro derecho...',
            hintStyle: TextStyle(color: AppColors.textTertiary),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar',
                style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _exercises[exerciseIdx].note = controller.text;
              });
              Navigator.pop(ctx);
            },
            child: const Text('Guardar',
                style: TextStyle(color: AppColors.accent)),
          ),
        ],
      ),
    );
  }

  // ─── ADD EXERCISE BUTTON ────────────────────────────────────

  Widget _buildAddExerciseButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: _addExercise,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(
                color: AppColors.accent.withOpacity(0.3), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_circle_outline, size: 18, color: AppColors.accent),
              SizedBox(width: 8),
              Text('Añadir ejercicio',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.accent)),
            ],
          ),
        ),
      ),
    );
  }

  // ─── FINISH BUTTON ──────────────────────────────────────────

  Widget _buildFinishButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      child: AppButton(
        text: 'Terminar rutina',
        type: AppButtonType.ghost,
        icon: const Icon(Icons.flag_outlined, size: 18, color: AppColors.accent),
        onPressed: _confirmFinish,
      ),
    );
  }

  // ─── REST TIMER OVERLAY ─────────────────────────────────────

  Widget _buildRestOverlay() {
    final progress = _restDuration > 0
        ? _restRemaining / _restDuration
        : 0.0;
    final minutes = (_restRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_restRemaining % 60).toString().padLeft(2, '0');

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: const Border(
            top: BorderSide(color: AppColors.border, width: 1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            // Timer label
            Text(
              'Descanso',
              style: GoogleFonts.cormorant(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 12),
            // Circular timer
            SizedBox(
              width: 100,
              height: 100,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 5,
                      backgroundColor: AppColors.border.withOpacity(0.2),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.accent),
                    ),
                  ),
                  Text(
                    '$minutes:$seconds',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _restButton('-15s', () => _adjustRest(-15)),
                const SizedBox(width: 12),
                _restActionButton('Saltar', _dismissRest),
                const SizedBox(width: 12),
                _restButton('+15s', () => _adjustRest(15)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _restButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.bg,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary)),
      ),
    );
  }

  Widget _restActionButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.bg)),
      ),
    );
  }
}
