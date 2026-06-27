import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final VoidCallback? onTap;

  const UserCard({
    super.key,
    required this.name,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const AvatarCircle(letters: 'JD', size: 52),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ActivityCardWidget extends StatelessWidget {
  final String name;
  final String initials;
  final String action;
  final String time;
  final VoidCallback? onTap;

  const ActivityCardWidget({
    super.key,
    required this.name,
    required this.initials,
    required this.action,
    required this.time,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          AvatarCircle(letters: initials, size: 36),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text)),
                const SizedBox(height: 1),
                Text(action,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          Text(time,
              style: const TextStyle(
                  fontSize: 11, color: AppColors.textTertiary)),
        ],
      ),
    );
  }
}

class GroupCard extends StatelessWidget {
  final String name;
  final int memberCount;
  final String? subtitle;
  final VoidCallback? onTap;

  const GroupCard({
    super.key,
    required this.name,
    required this.memberCount,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListItem(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: const Icon(Icons.group, color: AppColors.accent, size: 20),
      ),
      title: name,
      subtitle: subtitle != null
          ? '$memberCount miembros · $subtitle'
          : '$memberCount miembros',
      onTap: onTap,
    );
  }
}

class ProfileActivityItem extends StatelessWidget {
  final String title;
  final Widget trailing;

  const ProfileActivityItem({
    super.key,
    required this.title,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0x26B89066))),
      ),
      child: Row(
        children: [
          const Icon(Icons.fitness_center,
              color: AppColors.textSecondary, size: 16),
          const SizedBox(width: 10),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    fontSize: 14, color: AppColors.text)),
          ),
          trailing,
        ],
      ),
    );
  }
}

class RecordBadge extends StatelessWidget {
  const RecordBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text('Récord',
          style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.accent)),
    );
  }
}

class EventInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const EventInfoRow({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        Text(text,
            style: const TextStyle(
                fontSize: 13, color: AppColors.textSecondary)),
      ],
    );
  }
}

class AvatarStack extends StatelessWidget {
  final List<String> initials;

  const AvatarStack({
    super.key,
    this.initials = const ['MP', 'CL', 'JD', 'AG'],
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Stack(
        children: List.generate(initials.length, (i) {
          return Positioned(
            left: i * 22.0,
            child: AvatarCircle(letters: initials[i], size: 32),
          );
        }),
      ),
    );
  }
}
