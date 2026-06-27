class SocialActivity {
  final String name;
  final String initials;
  final String action;
  final String time;

  const SocialActivity({
    required this.name,
    required this.initials,
    required this.action,
    required this.time,
  });
}

class SocialGroup {
  final String name;
  final int memberCount;
  final String? subtitle;

  const SocialGroup({
    required this.name,
    required this.memberCount,
    this.subtitle,
  });
}

abstract class SocialRepository {
  List<SocialActivity> getActivities();
  List<SocialGroup> getGroups();
}
