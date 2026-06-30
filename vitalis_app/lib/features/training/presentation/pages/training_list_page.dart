import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/core/widgets/common_widgets.dart';

class TrainingList extends StatefulWidget {
  final void Function(String) push;
  const TrainingList({super.key, required this.push});
  @override
  State<TrainingList> createState() => _TrainingListState();
}

class _TrainingListState extends State<TrainingList> {
  bool _routinesExpanded = false;

  void Function(String) get _push => widget.push;

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
      onPressed: () => _push('crear'),
    );
  }

  Widget _rutinasHeader() {
    return Row(
      children: [
        const SectionTitle(text: 'RUTINAS'),
        const Spacer(),
        GestureDetector(
          onTap: () => _push('crear'),
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
            onTap: () => _push('crear'),
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
            onTap: () => _push('explorar'),
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
          onTap: () => setState(() {
            _routinesExpanded = !_routinesExpanded;
          }),
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
            onStart: () => _push('iniciar'),
          ),
          const SizedBox(height: 8),
          _RoutineCard(
            name: 'Pierna',
            exercises: ['Aducción de Caderas', 'Extensión de Pantorrilla', 'Curl de Pierna', 'Sentadilla'],
            onStart: () => _push('iniciar'),
          ),
          const SizedBox(height: 8),
          _RoutineCard(
            name: 'Pecho',
            exercises: ['Aperturas', 'Press de Banca Inclinado', 'Press de Banca en Decline'],
            onStart: () => _push('iniciar'),
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
