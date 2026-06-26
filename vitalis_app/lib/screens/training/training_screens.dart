import 'package:flutter/material.dart';
import 'package:vitalis_app/theme/app_theme.dart';
import 'package:vitalis_app/widgets/common_widgets.dart';
import 'package:vitalis_app/widgets/toast.dart';
import 'package:vitalis_app/widgets/phone_frame.dart';

// =============================================================================
// Navigation Host
// =============================================================================
class TrainingScreens extends StatefulWidget {
  final int tab;
  final PhoneFrameState phoneFrame;
  const TrainingScreens({super.key, required this.tab, required this.phoneFrame});

  @override
  State<TrainingScreens> createState() => TrainingScreensState();
}

class TrainingScreensState extends State<TrainingScreens> {
  final List<String> _stack = ['lista'];
  int get tab => widget.tab;

  void push(String view) { setState(() { _stack.add(view); }); }
  void pop() { if (_stack.length > 1) setState(() { _stack.removeLast(); }); }
  void popToRoot() { setState(() { _stack = ['lista']; }); }

  @override
  void initState() {
    super.initState();
    Nav.register(tab, push, pop);
  }

  @override
  Widget build(BuildContext context) {
    final view = _stack.last;
    return KeyedSubtree(
      key: ValueKey(view),
      child: _buildScreen(view),
    );
  }

  Widget _buildScreen(String view) {
    switch (view) {
      case 'lista':
        return const TrainingList();
      case 'crear':
        return const TrainingCreate();
      case 'ejercicios':
        return const TrainingExercises();
      case 'guardar':
        return const TrainingSaved();
      case 'explorar':
        return const TrainingExplorar();
      case 'editar':
        return const TrainingEditor();
      case 'iniciar':
        return const TrainingStart();
      case 'ejercicio-activo':
        return const TrainingActive();
      case 'ejercicio-activo2':
        return const TrainingActive2();
      case 'data':
        return const TrainingData();
      case 'opciones':
        return const TrainingOptions();
      case 'terminar':
        return const TrainingFinish();
      default:
        return const TrainingList();
    }
  }
}

// =============================================================================
// TrainingList — lista
// =============================================================================

class TrainingList extends StatefulWidget {
  const TrainingList({super.key});
  @override
  State<TrainingList> createState() => _TrainingListState();
}

class _TrainingListState extends State<TrainingList> {
  bool _routinesExpanded = false;

  TrainingScreensState? get _nav => context.findAncestorStateOfType<TrainingScreensState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Entrenamiento')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ctaButton(),
            const SizedBox(height: 24),
            _rutinasHeader(),
            const SizedBox(height: 12),
            _actionCards(),
            const SizedBox(height: 24),
            _misRutinasSection(),
          ],
        ),
      ),
    );
  }

  Widget _ctaButton() {
    return AppButton(
      text: 'Empezar Entrenamiento Vacío',
      icon: const Icon(Icons.play_arrow_rounded, size: 20),
      onPressed: () => _nav?.push('crear'),
    );
  }

  Widget _rutinasHeader() {
    return Row(
      children: [
        const SectionTitle(text: 'RUTINAS'),
        const Spacer(),
        GestureDetector(
          onTap: () => _nav?.push('crear'),
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.add, size: 18, color: AppColors.accent),
          ),
        ),
      ],
    );
  }

  Widget _actionCards() {
    return Row(
      children: [
        Expanded(
          child: AppCard(
            onTap: () => _nav?.push('crear'),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.add, size: 20, color: AppColors.accent),
                ),
                const SizedBox(width: 12),
                const Text('Nueva Rutina',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.text)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: AppCard(
            onTap: () => _nav?.push('explorar'),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.border.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.explore_outlined, size: 20, color: AppColors.border),
                ),
                const SizedBox(width: 12),
                const Text('Explorar',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.text)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _misRutinasSection() {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() { _routinesExpanded = !_routinesExpanded; }),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                const Text('Mis rutinas (3)',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.text)),
                const Spacer(),
                Icon(
                  _routinesExpanded ? Icons.expand_less : Icons.expand_more,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        if (_routinesExpanded) ...[
          const SizedBox(height: 8),
          _RoutineCard(
            name: 'Espalda',
            exercises: ['Pull Over', 'Jalón al Pecho', 'Remo Sentado', 'Vuelos Posteriores'],
            onStart: () => _nav?.push('iniciar'),
          ),
          const SizedBox(height: 8),
          _RoutineCard(
            name: 'Pierna',
            exercises: ['Aducción de Caderas', 'Extensión de Pantorrilla', 'Curl de Pierna', 'Sentadilla'],
            onStart: () => _nav?.push('iniciar'),
          ),
          const SizedBox(height: 8),
          _RoutineCard(
            name: 'Pecho',
            exercises: ['Aperturas', 'Press de Banca Inclinado', 'Press de Banca en Declive'],
            onStart: () => _nav?.push('iniciar'),
          ),
        ],
      ],
    );
  }
}

class _RoutineCard extends StatelessWidget {
  final String name;
  final List<String> exercises;
  final VoidCallback onStart;

  const _RoutineCard({
    required this.name,
    required this.exercises,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.accent)),
          const SizedBox(height: 4),
          Text('${exercises.length} ejercicios',
              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          const SizedBox(height: 8),
          ...exercises.map((e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    const Icon(Icons.fiber_manual_record, size: 6, color: AppColors.textSecondary),
                    const SizedBox(width: 8),
                    Text(e, style: const TextStyle(fontSize: 13, color: AppColors.text)),
                  ],
                ),
              )),
          const SizedBox(height: 8),
          AppButton(text: 'Empezar Rutina', type: AppButtonType.secondary, onPressed: onStart),
        ],
      ),
    );
  }
}

// =============================================================================
// TrainingCreate — crear
// =============================================================================

class TrainingCreate extends StatefulWidget {
  const TrainingCreate({super.key});
  @override
  State<TrainingCreate> createState() => _TrainingCreateState();
}

class _TrainingCreateState extends State<TrainingCreate> {
  final _titleController = TextEditingController();
  bool get _hasTitle => _titleController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  TrainingScreensState? get _nav => context.findAncestorStateOfType<TrainingScreensState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () => _nav?.pop(),
          child: const Text('Cancelar',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
        ),
        title: const Text('Nueva Rutina'),
        actions: [
          TextButton(
            onPressed: _hasTitle ? () => _nav?.push('guardar') : null,
            child: Text('Guardar',
                style: TextStyle(
                  color: _hasTitle ? AppColors.accent : AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              onChanged: (_) => setState(() {}),
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.text),
              decoration: InputDecoration(
                hintText: 'Nombre de la rutina',
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: _hasTitle ? AppColors.accent : AppColors.border.withOpacity(0.3)),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.border.withOpacity(0.3)),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.accent, width: 2),
                ),
                filled: false,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 60),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.fitness_center_outlined,
                        size: 32, color: AppColors.accent),
                  ),
                  const SizedBox(height: 16),
                  const Text('Empieza agregando un ejercicio',
                      style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                  const SizedBox(height: 16),
                  AppButton(
                    text: 'Agregar ejercicio',
                    icon: const Icon(Icons.add, size: 18),
                    type: AppButtonType.secondary,
                    onPressed: () => _nav?.push('ejercicios'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// TrainingExercises — ejercicios
// =============================================================================

class TrainingExercises extends StatefulWidget {
  const TrainingExercises({super.key});
  @override
  State<TrainingExercises> createState() => _TrainingExercisesState();
}

class _TrainingExercisesState extends State<TrainingExercises> {
  final _searchController = TextEditingController();
  final Set<String> _selected = {};
  String _equipFilter = 'Todo Equipamiento';
  String _muscleFilter = 'Todos Músculos';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  TrainingScreensState? get _nav => context.findAncestorStateOfType<TrainingScreensState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: () => _nav?.pop(),
        ),
        title: const Text('Agregar Ejercicios'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
              children: [
                _searchField(),
                const SizedBox(height: 12),
                _filterChips(),
                const SizedBox(height: 16),
                _exerciseList(),
              ],
            ),
          ),
          _bottomCta(),
        ],
      ),
    );
  }

  Widget _searchField() {
    return TextField(
      controller: _searchController,
      decoration: const InputDecoration(
        hintText: 'Buscar ejercicio...',
        prefixIcon: Icon(Icons.search, color: AppColors.textSecondary, size: 20),
      ),
    );
  }

  Widget _filterChips() {
    final equip = ['Todo Equipamiento', 'Mancuerna', 'Máquina', 'Cable'];
    final muscle = ['Todos Músculos', 'Pecho', 'Hombros', 'Tríceps', 'Pierna'];
    return SizedBox(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...equip.map((c) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Chip(
                  text: c,
                  selected: _equipFilter == c,
                  onTap: () => setState(() { _equipFilter = c; }),
                ),
              )),
          ...muscle.map((c) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Chip(
                  text: c,
                  selected: _muscleFilter == c,
                  onTap: () => setState(() { _muscleFilter = c; }),
                ),
              )),
        ],
      ),
    );
  }

  Widget _exerciseList() {
    final exercises = [
      ('Aperturas', 'Máquina'),
      ('Press de Banca Inclinado', 'Mancuerna'),
      ('Press de Banca en Declive', 'Máquina'),
      ('Press de Hombros', 'Máquina de Discos'),
      ('Elevación Laterales', 'Mancuerna'),
      ('Extensión de Tríceps', 'Cable'),
      ('Tríceps con Polea', ''),
      ('Aducción de Caderas', ''),
    ];
    return Column(children: exercises.map((e) => _exerciseRow(e.$1, e.$2)).toList());
  }

  Widget _exerciseRow(String name, String equipment) {
    final isSelected = _selected.contains(name);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0x26B89066))),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border.withOpacity(0.3)),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.fitness_center, size: 18, color: AppColors.textSecondary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.text)),
                if (equipment.isNotEmpty)
                  Text(equipment,
                      style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                if (isSelected) {
                  _selected.remove(name);
                } else {
                  _selected.add(name);
                }
              });
            },
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.accent : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                    color: isSelected ? AppColors.accent : AppColors.border),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16, color: AppColors.bg)
                  : const Icon(Icons.add, size: 16, color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomCta() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: const BoxDecoration(
        color: AppColors.bg,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: AppButton(
        text: _selected.isEmpty
            ? 'Selecciona ejercicios'
            : 'Agrega ${_selected.length} ejercicio(s)',
        disabled: _selected.isEmpty,
        onPressed: () => _nav?.push('guardar'),
      ),
    );
  }
}

// =============================================================================
// TrainingSaved — guardar
// =============================================================================

class TrainingSaved extends StatelessWidget {
  const TrainingSaved({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.findAncestorStateOfType<TrainingScreensState>();
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Spacer(),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_outline,
                  size: 48, color: AppColors.accent),
            ),
            const SizedBox(height: 20),
            const Text('Rutina guardada',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.text)),
            const SizedBox(height: 8),
            const Text('Tu rutina se ha guardado exitosamente',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
            const SizedBox(height: 32),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('¿Qué sigue?',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.text)),
                  const SizedBox(height: 12),
                  const Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: AppColors.accent),
                      SizedBox(width: 8),
                      Text('Programada para LUN · MIE · VIE',
                          style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            AppButton(
              text: 'Volver a rutinas',
              type: AppButtonType.secondary,
              onPressed: () => nav?.popToRoot(),
            ),
            const SizedBox(height: 8),
            AppButton(
              text: 'Iniciar ahora',
              icon: const Icon(Icons.play_arrow_rounded, size: 20),
              onPressed: () => nav?.push('iniciar'),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// TrainingExplorar — explorar
// =============================================================================

class TrainingExplorar extends StatefulWidget {
  const TrainingExplorar({super.key});
  @override
  State<TrainingExplorar> createState() => _TrainingExplorarState();
}

class _TrainingExplorarState extends State<TrainingExplorar> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nav = context.findAncestorStateOfType<TrainingScreensState>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: () => nav?.pop(),
        ),
        title: const Text('Explorar'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Buscar rutinas...',
              prefixIcon: Icon(Icons.search, color: AppColors.textSecondary, size: 20),
            ),
          ),
          const SizedBox(height: 24),
          const SectionTitle(text: 'POPULARES'),
          const SizedBox(height: 8),
          _popularCard('Full Body Principiante', '3 ejercicios · ~30 min', nav),
          const SizedBox(height: 8),
          _popularCard('Push Pull Legs', '9 ejercicios · ~60 min', nav),
          const SizedBox(height: 8),
          _popularCard('Core 10 minutos', '5 ejercicios · ~10 min', nav),
        ],
      ),
    );
  }

  Widget _popularCard(String title, String subtitle, TrainingScreensState? nav) {
    return AppCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.text)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          AppButton(
            text: 'Ver y editar',
            type: AppButtonType.secondary,
            width: 120,
            onPressed: () => nav?.push('editar'),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TrainingEditor — editar
// =============================================================================

class TrainingEditor extends StatefulWidget {
  const TrainingEditor({super.key});
  @override
  State<TrainingEditor> createState() => _TrainingEditorState();
}

class _SerieRow {
  final int number;
  final String kg;
  final String reps;
  const _SerieRow({required this.number, required this.kg, required this.reps});
}

class _TrainingEditorState extends State<TrainingEditor> {
  final _titleController = TextEditingController(text: 'Push intensivo');
  final _notesController = TextEditingController();
  bool _restTimer = true;
  late List<_SerieRow> _series;

  @override
  void initState() {
    super.initState();
    _series = List.generate(3, (i) => _SerieRow(number: i + 1, kg: '', reps: ''));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  TrainingScreensState? get _nav => context.findAncestorStateOfType<TrainingScreensState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () => _nav?.pop(),
          child: const Text('Cancelar',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
        ),
        title: const Text('Editar Rutina'),
        actions: [
          TextButton(
            onPressed: () => _nav?.pop(),
            child: const Text('Guardar',
                style: TextStyle(
                    color: AppColors.accent, fontSize: 14, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          _titleField(),
          const SizedBox(height: 20),
          _exerciseCard(),
          const SizedBox(height: 12),
          _addExerciseButton(),
          const SizedBox(height: 12),
          ToggleRow(
            label: 'Descanso automático',
            subLabel: '2:30 entre series',
            value: _restTimer,
            onChanged: (v) => setState(() { _restTimer = v; }),
          ),
        ],
      ),
    );
  }

  Widget _titleField() {
    return TextField(
      controller: _titleController,
      style: const TextStyle(
          fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.text),
      decoration: const InputDecoration(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0x4DB89066))),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0x4DB89066))),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.accent, width: 2)),
        filled: false,
        contentPadding: EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }

  void _updateKg(int index, String value) {
    setState(() {
      _series[index] = _SerieRow(number: _series[index].number, kg: value, reps: _series[index].reps);
    });
  }

  void _updateReps(int index, String value) {
    setState(() {
      _series[index] = _SerieRow(number: _series[index].number, kg: _series[index].kg, reps: value);
    });
  }

  Widget _exerciseCard() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(Icons.fitness_center, size: 18, color: AppColors.accent),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text('Aperturas (Máquina)',
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.text)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _notesController,
            style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
            decoration: const InputDecoration(
              hintText: 'Notas del ejercicio...',
              border: InputBorder.none,
              filled: false,
              contentPadding: EdgeInsets.zero,
              isDense: true,
            ),
          ),
          const SizedBox(height: 16),
          _seriesTableHeader(),
          ..._series.asMap().entries.map((e) => _serieRow(e.key, e.value)),
          const SizedBox(height: 8),
          _addSeriesButton(),
        ],
      ),
    );
  }

  Widget _seriesTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0x26B89066))),
      ),
      child: const Row(
        children: [
          SizedBox(
            width: 40,
            child: Text('Serie',
                style: TextStyle(
                    fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
          ),
          Expanded(
            child: Text('KG',
                style: TextStyle(
                    fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
          ),
          Expanded(
            child: Text('REPS',
                style: TextStyle(
                    fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _serieRow(int index, _SerieRow serie) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0x1AB89066))),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text('${serie.number}',
                style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          ),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 13, color: AppColors.text),
              decoration: const InputDecoration(
                filled: false,
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (v) => _updateKg(index, v),
            ),
          ),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 13, color: AppColors.text),
              decoration: const InputDecoration(
                filled: false,
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (v) => _updateReps(index, v),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addSeriesButton() {
    return TextButton.icon(
      onPressed: () {
        setState(() {
          _series.add(_SerieRow(number: _series.length + 1, kg: '', reps: ''));
        });
      },
      icon: const Icon(Icons.add, size: 16, color: AppColors.accent),
      label: const Text('Agregar Serie',
          style: TextStyle(color: AppColors.accent, fontSize: 13)),
    );
  }

  Widget _addExerciseButton() {
    return TextButton.icon(
      onPressed: () => _nav?.push('ejercicios'),
      icon: const Icon(Icons.add, size: 18, color: AppColors.accent),
      label: const Text('Agregar ejercicio',
          style: TextStyle(color: AppColors.accent, fontSize: 14)),
    );
  }
}

// =============================================================================
// TrainingStart — iniciar
// =============================================================================

class TrainingStart extends StatelessWidget {
  const TrainingStart({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.findAncestorStateOfType<TrainingScreensState>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: () => nav?.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          const Text('Push intensivo',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.text)),
          const SizedBox(height: 4),
          const Text('8 ejercicios · ~45 min',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
          const SizedBox(height: 24),
          _warmupCard(),
          const SizedBox(height: 16),
          const SectionTitle(text: 'EJERCICIOS'),
          ListItem(
            leading: _exerciseIcon(),
            title: 'Press banca',
            subtitle: '4 × 10-12 repeticiones',
          ),
          ListItem(
            leading: _exerciseIcon(),
            title: 'Press inclinado',
            subtitle: '3 × 10-12 repeticiones',
          ),
          ListItem(
            leading: _exerciseIcon(),
            title: 'Aperturas',
            subtitle: '3 × 12-15 repeticiones',
          ),
          const SizedBox(height: 24),
          AppButton(
            text: 'Comenzar rutina',
            icon: const Icon(Icons.play_arrow_rounded, size: 20),
            onPressed: () => nav?.push('ejercicio-activo'),
          ),
        ],
      ),
    );
  }

  Widget _warmupCard() {
    return AppCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.local_fire_department_outlined,
                size: 20, color: AppColors.accent),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Calentamiento',
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.text)),
              const Text('5 min',
                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _exerciseIcon() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Icon(Icons.fitness_center, size: 16, color: AppColors.textSecondary),
    );
  }
}

// =============================================================================
// TrainingActive / TrainingActive2 — ejercicio-activo / ejercicio-activo2
// =============================================================================

class TrainingActive extends StatelessWidget {
  const TrainingActive({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ActiveExerciseView(
      currentSet: 1,
      totalSets: 4,
      timerText: '03:24',
      exerciseName: 'Press banca',
      showFinishButton: false,
    );
  }
}

class TrainingActive2 extends StatelessWidget {
  const TrainingActive2({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ActiveExerciseView(
      currentSet: 2,
      totalSets: 4,
      timerText: '05:52',
      exerciseName: 'Press banca',
      showFinishButton: true,
    );
  }
}

class _ActiveExerciseView extends StatelessWidget {
  final int currentSet;
  final int totalSets;
  final String timerText;
  final String exerciseName;
  final bool showFinishButton;

  const _ActiveExerciseView({
    required this.currentSet,
    required this.totalSets,
    required this.timerText,
    required this.exerciseName,
    required this.showFinishButton,
  });

  @override
  Widget build(BuildContext context) {
    final nav = context.findAncestorStateOfType<TrainingScreensState>();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Pill(text: '1/8', type: PillType.success),
            const SizedBox(width: 8),
            Text(timerText,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.accent)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.textSecondary),
            onPressed: () => nav?.push('opciones'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(exerciseName,
                style: const TextStyle(
                    fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.text)),
            const SizedBox(height: 32),
            AppCard(
              child: Column(
                children: [
                  Text('Serie $currentSet de $totalSets',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.accent)),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      StatCard(value: '60', label: 'KG'),
                      SizedBox(width: 8),
                      StatCard(value: '10', label: 'Reps'),
                      SizedBox(width: 8),
                      StatCard(value: '2:30', label: 'Descanso'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _chip('Completada', () {}),
                const SizedBox(width: 8),
                _chip('Ver datos', () => nav?.push('data')),
                const SizedBox(width: 8),
                _chip('Opciones', () => nav?.push('opciones')),
              ],
            ),
            const Spacer(),
            AppButton(
              text: 'Siguiente serie',
              onPressed: () => nav?.push('ejercicio-activo2'),
            ),
            if (showFinishButton) ...[
              const SizedBox(height: 8),
              AppButton(
                text: 'Terminar rutina',
                type: AppButtonType.ghost,
                onPressed: () => nav?.push('terminar'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _chip(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label,
            style: const TextStyle(fontSize: 13, color: AppColors.text)),
      ),
    );
  }
}

// =============================================================================
// TrainingData — data
// =============================================================================

class TrainingData extends StatelessWidget {
  const TrainingData({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.findAncestorStateOfType<TrainingScreensState>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: () => nav?.pop(),
        ),
        title: const Text('Press banca - Datos'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          const Row(
            children: [
              StatCard(value: '60', label: 'Actual (kg)'),
              SizedBox(width: 8),
              StatCard(value: '55', label: 'Previo (kg)'),
              SizedBox(width: 8),
              StatCard(value: '+5', label: 'Progreso'),
            ],
          ),
          const SizedBox(height: 24),
          _historialCard(),
          const SizedBox(height: 16),
          _volumenCard(),
        ],
      ),
    );
  }

  Widget _historialCard() {
    final entries = [
      ('12/06', '60 kg × 10 reps'),
      ('09/06', '55 kg × 10 reps'),
      ('06/06', '55 kg × 8 reps'),
      ('03/06', '50 kg × 10 reps'),
    ];
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('HISTORIAL DE CARGAS',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accent,
                  letterSpacing: 0.05)),
          const SizedBox(height: 12),
          ...entries.map((e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Text(e.$1,
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(width: 16),
                    Text(e.$2,
                        style: const TextStyle(fontSize: 13, color: AppColors.text)),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _volumenCard() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('VOLUMEN TOTAL',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accent,
                  letterSpacing: 0.05)),
          const SizedBox(height: 8),
          const Text('2,400 kg',
              style: TextStyle(
                  fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.accent)),
          const Text('Esta sesión',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

// =============================================================================
// TrainingOptions — opciones
// =============================================================================

class TrainingOptions extends StatefulWidget {
  const TrainingOptions({super.key});
  @override
  State<TrainingOptions> createState() => _TrainingOptionsState();
}

class _TrainingOptionsState extends State<TrainingOptions> {
  bool _autoPause = true;
  bool _sound = false;
  bool _focus = true;

  @override
  Widget build(BuildContext context) {
    final nav = context.findAncestorStateOfType<TrainingScreensState>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: () => nav?.pop(),
        ),
        title: const Text('Opciones'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ToggleRow(
              label: 'Pausa automática',
              value: _autoPause,
              onChanged: (v) => setState(() { _autoPause = v; }),
            ),
            ToggleRow(
              label: 'Sonido al completar',
              value: _sound,
              onChanged: (v) => setState(() { _sound = v; }),
            ),
            ToggleRow(
              label: 'Modo concentración',
              value: _focus,
              onChanged: (v) => setState(() { _focus = v; }),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// TrainingFinish — terminar
// =============================================================================

class TrainingFinish extends StatelessWidget {
  const TrainingFinish({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.findAncestorStateOfType<TrainingScreensState>();
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Spacer(),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.star_rounded, size: 48, color: AppColors.accent),
            ),
            const SizedBox(height: 16),
            const Text('Rutina completada',
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.text)),
            const SizedBox(height: 4),
            const Text('Push intensivo · 46 min',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
            const SizedBox(height: 32),
            _statsRow(),
            const SizedBox(height: 16),
            _bestMarkCard(),
            const SizedBox(height: 24),
            AppButton(text: 'Finalizar', onPressed: () => nav?.popToRoot()),
            const SizedBox(height: 8),
            AppButton(
              text: 'Compartir',
              type: AppButtonType.secondary,
              icon: const Icon(Icons.share, size: 18),
              onPressed: () {
                ToastOverlayState.of(context)?.show('Enlace copiado');
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _statsRow() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        children: [
          StatCard(value: '8', label: 'Ejercicios'),
          SizedBox(width: 8),
          StatCard(value: '32', label: 'Series'),
          SizedBox(width: 8),
          StatCard(value: '346', label: 'Kcal'),
        ],
      ),
    );
  }

  Widget _bestMarkCard() {
    return AppCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.emoji_events_outlined, size: 20, color: AppColors.accent),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('¡Mejor marca!',
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.text)),
              const Text('+5 kg en Press de Banca',
                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ],
          ),
        ],
      ),
    );
  }
}
