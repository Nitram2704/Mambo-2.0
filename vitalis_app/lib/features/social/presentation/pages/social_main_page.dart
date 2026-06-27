import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';
import '../../data/mock_social_repository.dart';
import '../widgets/social_widgets.dart';

class SocialMainPage extends StatelessWidget {
  final void Function(String) onNavigate;
  final void Function(String name, String initials, String username,
      int level, int streak, int logros, int grupos) onShowProfile;

  const SocialMainPage({
    super.key,
    required this.onNavigate,
    required this.onShowProfile,
  });

  @override
  Widget build(BuildContext context) {
    final repo = MockSocialRepository();
    final activities = repo.getActivities();
    final groups = repo.getGroups();

    return Scaffold(
      appBar: AppBar(title: const Text('Social')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 80),
        children: [
          UserCard(
            name: 'Juan David',
            subtitle: '12 grupos · 8 eventos este mes',
            onTap: () {},
          ),
          const SectionTitle(text: 'ACTIVIDAD RECIENTE'),
          ActivityCardWidget(
            name: activities[0].name,
            initials: activities[0].initials,
            action: activities[0].action,
            time: activities[0].time,
            onTap: () => onShowProfile(
                'María Pérez', 'MP', '@mariaperez', 12, 7, 5, 3),
          ),
          const SizedBox(height: 8),
          ActivityCardWidget(
            name: activities[1].name,
            initials: activities[1].initials,
            action: activities[1].action,
            time: activities[1].time,
            onTap: () => onShowProfile(
                'Carlos López', 'CL', '@carloslopez', 18, 14, 9, 5),
          ),
          const SizedBox(height: 8),
          ActivityCardWidget(
            name: activities[2].name,
            initials: activities[2].initials,
            action: activities[2].action,
            time: activities[2].time,
            onTap: () => onShowProfile(
                'Ana García', 'AG', '@anagarcia', 8, 3, 4, 2),
          ),
          const SectionTitle(text: 'GRUPOS'),
          GroupCard(
            name: groups[0].name,
            memberCount: groups[0].memberCount,
            subtitle: groups[0].subtitle,
            onTap: () {},
          ),
          GroupCard(
            name: groups[1].name,
            memberCount: groups[1].memberCount,
            subtitle: groups[1].subtitle,
            onTap: () {},
          ),
          GroupCard(
            name: groups[2].name,
            memberCount: groups[2].memberCount,
            subtitle: groups[2].subtitle,
            onTap: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onNavigate('crear-grupo'),
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.bg,
        child: const Icon(Icons.add),
      ),
    );
  }
}
