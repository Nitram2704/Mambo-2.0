import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/core/widgets/toast.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/activity.dart';

class GreetingWidget extends StatelessWidget {
  final String initials;
  final VoidCallback onProfileTap;

  const GreetingWidget({super.key, required this.initials, required this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onProfileTap,
          child: AvatarCircle(letters: initials, size: 48),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('¡Hola de nuevo!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.text, height: 1.2)),
              const SizedBox(height: 2),
              const Text('Tu progreso hoy', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            ],
          ),
        ),
      ],
    );
  }
}

class QuickCardData {
  final String title;
  final String subtitle;
  final IconData icon;
  const QuickCardData(this.title, this.subtitle, this.icon);
}

class QuickAccessCard extends StatelessWidget {
  final QuickCardData data;
  const QuickAccessCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(14),
      onTap: () => ToastOverlayState.of(context)?.show('Próximamente'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(data.icon, color: AppColors.accent, size: 20),
          ),
          const SizedBox(height: 10),
          Text(data.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.text)),
          const SizedBox(height: 2),
          Text(data.subtitle, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}


class ActivityCardWidget extends StatelessWidget {
  final Activity data;
  const ActivityCardWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: AppColors.surfaceHover, borderRadius: BorderRadius.circular(8)),
            child: Icon(data.icon, color: AppColors.accent, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.text)),
                const SizedBox(height: 1),
                Text(data.time, style: const TextStyle(fontSize: 11, color: AppColors.textTertiary)),
              ],
            ),
          ),
          Text(data.value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.accent)),
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final User user;
  final VoidCallback onEdit;

  const ProfileHeader({super.key, required this.user, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            const AvatarCircle(letters: 'V', size: 72),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.bg, width: 2),
                ),
                child: const Icon(Icons.star, color: Color(0xFF0F0F0F), size: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(user.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.text)),
        const SizedBox(height: 4),
        Text(user.username, style: const TextStyle(fontSize: 13, color: AppColors.accent)),
        const SizedBox(height: 4),
        Text('Miembro desde ${user.memberSince} · Plan: ${user.plan}',
            style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
        const SizedBox(height: 12),
        InkWell(
          onTap: onEdit,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(20)),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.edit, color: AppColors.accent, size: 14),
                SizedBox(width: 6),
                Text('Editar perfil', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.accent)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
