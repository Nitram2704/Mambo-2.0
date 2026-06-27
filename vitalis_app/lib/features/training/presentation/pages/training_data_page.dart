import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/core/widgets/common_widgets.dart';

class TrainingData extends StatelessWidget {
  final VoidCallback pop;
  const TrainingData({super.key, required this.pop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: pop,
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
