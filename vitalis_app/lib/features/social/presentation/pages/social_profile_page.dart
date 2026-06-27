import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';
import '../widgets/social_widgets.dart';

class SocialProfilePage extends StatelessWidget {
  final String name;
  final String initials;
  final String username;
  final int level;
  final int streak;
  final int logros;
  final int grupos;
  final VoidCallback onPop;

  const SocialProfilePage({
    super.key,
    required this.name,
    required this.initials,
    required this.username,
    required this.level,
    required this.streak,
    required this.logros,
    required this.grupos,
    required this.onPop,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onPop,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
        children: [
          Center(
            child: Column(
              children: [
                AvatarCircle(letters: initials, size: 80),
                const SizedBox(height: 12),
                Text(name,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text)),
                Text(username,
                    style: const TextStyle(
                        fontSize: 14, color: AppColors.textSecondary)),
                const SizedBox(height: 4),
                const Text('Miembro desde 2024',
                    style: TextStyle(
                        fontSize: 12, color: AppColors.textTertiary)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              StatCard(value: '$level', label: 'Nivel'),
              const SizedBox(width: 8),
              StatCard(value: '$streak', label: 'Racha actual'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              StatCard(value: '$logros', label: 'Logros'),
              const SizedBox(width: 8),
              StatCard(value: '$grupos', label: 'Grupos'),
            ],
          ),
          const SectionTitle(text: 'ACTIVIDAD RECIENTE'),
          const ProfileActivityItem(
            title: 'Press banca 80 kg',
            trailing: RecordBadge(),
          ),
          ProfileActivityItem(
            title: 'Reto 30 días Día 24/30',
            trailing: const Pill(text: 'En curso', type: PillType.info),
          ),
          const ProfileActivityItem(
            title: 'Carrera 5K 26:34',
            trailing: Text('26:34',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accent)),
          ),
          const SizedBox(height: 20),
          AppButton(
            text: 'Agregar amigo',
            icon: const Icon(Icons.person_add, size: 18),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
