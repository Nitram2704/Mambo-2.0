import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/core/widgets/common_widgets.dart';

class TrainingActive extends StatelessWidget {
  final void Function(String) push;
  const TrainingActive({super.key, required this.push});

  @override
  Widget build(BuildContext context) {
    return _ActiveExerciseView(
      push: push,
      currentSet: 1,
      totalSets: 4,
      timerText: '03:24',
      exerciseName: 'Press banca',
      showFinishButton: false,
    );
  }
}

class TrainingActive2 extends StatelessWidget {
  final void Function(String) push;
  const TrainingActive2({super.key, required this.push});

  @override
  Widget build(BuildContext context) {
    return _ActiveExerciseView(
      push: push,
      currentSet: 2,
      totalSets: 4,
      timerText: '05:52',
      exerciseName: 'Press banca',
      showFinishButton: true,
    );
  }
}

class _ActiveExerciseView extends StatelessWidget {
  final void Function(String) push;
  final int currentSet;
  final int totalSets;
  final String timerText;
  final String exerciseName;
  final bool showFinishButton;

  const _ActiveExerciseView({
    required this.push,
    required this.currentSet,
    required this.totalSets,
    required this.timerText,
    required this.exerciseName,
    required this.showFinishButton,
  });

  @override
  Widget build(BuildContext context) {
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
            onPressed: () => push('opciones'),
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
                _chip('Ver datos', () => push('data')),
                const SizedBox(width: 8),
                _chip('Opciones', () => push('opciones')),
              ],
            ),
            const Spacer(),
            AppButton(
              text: 'Siguiente serie',
              onPressed: () => push('ejercicio-activo2'),
            ),
            if (showFinishButton) ...[
              const SizedBox(height: 8),
              AppButton(
                text: 'Terminar rutina',
                type: AppButtonType.ghost,
                onPressed: () => push('terminar'),
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
