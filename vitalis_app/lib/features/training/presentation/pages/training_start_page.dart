import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/core/widgets/common_widgets.dart';

class TrainingStart extends StatelessWidget {
  final VoidCallback pop;
  final void Function(String) push;
  const TrainingStart({super.key, required this.pop, required this.push});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: pop,
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
            onPressed: () => push('ejercicio-activo'),
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
              color: AppColors.accent.withValues(alpha: 0.15),
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
