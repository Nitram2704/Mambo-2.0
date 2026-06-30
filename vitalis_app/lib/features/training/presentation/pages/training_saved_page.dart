import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/core/widgets/common_widgets.dart';

class TrainingSaved extends StatelessWidget {
  final VoidCallback popToRoot;
  final void Function(String) push;
  const TrainingSaved({super.key, required this.popToRoot, required this.push});

  @override
  Widget build(BuildContext context) {
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
              onPressed: popToRoot,
            ),
            const SizedBox(height: 8),
            AppButton(
              text: 'Iniciar ahora',
              icon: const Icon(Icons.play_arrow_rounded, size: 20),
              onPressed: () => push('iniciar'),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
