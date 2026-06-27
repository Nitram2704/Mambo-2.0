import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';
import '../widgets/social_widgets.dart';

class SocialEventPage extends StatelessWidget {
  final VoidCallback onPop;
  final void Function(String) onNavigate;

  const SocialEventPage({
    super.key,
    required this.onPop,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evento'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onPop,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
        children: [
          AppCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Carrera 5K',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text)),
                const SizedBox(height: 8),
                const EventInfoRow(
                    icon: Icons.calendar_today, text: 'Sábado 28 jun'),
                const SizedBox(height: 4),
                const EventInfoRow(icon: Icons.access_time, text: '08:00'),
                const SizedBox(height: 4),
                const EventInfoRow(
                    icon: Icons.location_on, text: 'Parque Central'),
              ],
            ),
          ),
          const SectionTitle(text: 'PARTICIPANTES (12)'),
          AppCard(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const AvatarStack(),
                const Spacer(),
                const Text('+12',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary)),
              ],
            ),
          ),
          const SectionTitle(text: 'EVIDENCIA'),
          AppCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Sube tu resultado',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text)),
                const SizedBox(height: 4),
                const Text('Comparte tu tiempo o distancia',
                    style: TextStyle(
                        fontSize: 12, color: AppColors.textSecondary)),
                const SizedBox(height: 12),
                AppButton(
                  text: 'Subir evidencia',
                  type: AppButtonType.secondary,
                  onPressed: () => onNavigate('evidencia'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          AppButton(
            text: 'Unirse al evento',
            icon: const Icon(Icons.event, size: 18),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
