import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import 'package:vitalis_app/core/widgets/toast.dart';

class TrainingFinish extends StatelessWidget {
  final VoidCallback popToRoot;
  const TrainingFinish({super.key, required this.popToRoot});

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
                color: AppColors.accent.withValues(alpha: 0.15),
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
            AppButton(text: 'Finalizar', onPressed: popToRoot),
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
              color: AppColors.accent.withValues(alpha: 0.15),
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
