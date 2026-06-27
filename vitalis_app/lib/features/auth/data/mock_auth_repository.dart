import '../domain/entities/auth_user.dart';
import '../domain/repositories/auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  final _delay = Duration(milliseconds: 800);

  @override
  Future<AuthUser> login(String email, String password) async {
    await Future.delayed(_delay);
    return AuthUser(name: 'Usuario', email: email);
  }

  @override
  Future<AuthUser> register(String name, String email, String password) async {
    await Future.delayed(_delay);
    return AuthUser(name: name, email: email);
  }

  @override
  Future<void> savePlan(Map<String, dynamic> plan) async {
    await Future.delayed(_delay);
  }

  @override
  Future<void> logout() async {
    await Future.delayed(_delay);
  }
}
