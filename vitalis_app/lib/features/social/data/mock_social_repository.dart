import '../domain/entities/social_profile.dart';
import '../domain/repositories/social_repository.dart';

class MockSocialRepository implements SocialRepository {
  @override
  List<SocialActivity> getActivities() {
    return const [
      SocialActivity(
        name: 'María Pérez',
        initials: 'MP',
        action: 'Completó Reto 30 días',
        time: 'hace 2h',
      ),
      SocialActivity(
        name: 'Carlos López',
        initials: 'CL',
        action: 'Nuevo récord press banca 80 kg',
        time: 'hace 5h',
      ),
      SocialActivity(
        name: 'Ana García',
        initials: 'AG',
        action: 'Subió evidencia',
        time: 'hace 1d',
      ),
    ];
  }

  @override
  List<SocialGroup> getGroups() {
    return const [
      SocialGroup(name: 'Reto 30 días', memberCount: 23),
      SocialGroup(name: 'Running Club', memberCount: 15, subtitle: 'Evento mañana'),
      SocialGroup(name: 'Yoga & Meditación', memberCount: 8),
    ];
  }

  SocialProfile getOwnProfile() {
    return const SocialProfile(
      name: 'Juan David',
      initials: 'JD',
      username: '@juandavid',
      level: 10,
      streak: 5,
      logros: 7,
      grupos: 12,
    );
  }
}
