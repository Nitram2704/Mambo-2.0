import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/core/widgets/common_widgets.dart';

class SleepMainPage extends StatelessWidget {
  final void Function(String) push;
  const SleepMainPage({super.key, required this.push});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sueño')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              const RingProgress(progress: 0.9, text: '7:12'),
              const SizedBox(width: 16),
              const StatCard(value: '92', label: 'Puntaje'),
              const SizedBox(width: 8),
              const StatCard(value: '6d', label: 'Racha'),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Objetivo: 8:00 h',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.2),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: AppCard(
                  onTap: () => push('registrar'),
                  padding: const EdgeInsets.all(14),
                  child: const Column(
                    children: [
                      Icon(Icons.bedtime_outlined, color: AppColors.accent, size: 28),
                      SizedBox(height: 8),
                      Text(
                        'Registrar\nsueño',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: AppColors.text, height: 1.3),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppCard(
                  onTap: () => push('recordatorio'),
                  padding: const EdgeInsets.all(14),
                  child: const Column(
                    children: [
                      Icon(Icons.notifications_outlined, color: AppColors.accent, size: 28),
                      SizedBox(height: 8),
                      Text(
                        'Generar\nrecordatorio',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: AppColors.text, height: 1.3),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppCard(
                  onTap: () => push('historial'),
                  padding: const EdgeInsets.all(14),
                  child: const Column(
                    children: [
                      Icon(Icons.history, color: AppColors.accent, size: 28),
                      SizedBox(height: 8),
                      Text(
                        'Historial',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: AppColors.text, height: 1.3),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppCard(
                  onTap: () => push('objetivo'),
                  padding: const EdgeInsets.all(14),
                  child: const Column(
                    children: [
                      Icon(Icons.track_changes, color: AppColors.accent, size: 28),
                      SizedBox(height: 8),
                      Text(
                        'Objetivo',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: AppColors.text, height: 1.3),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
