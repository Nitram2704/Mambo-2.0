import '../entities/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser> login(String email, String password);
  Future<AuthUser> register(String name, String email, String password);
  Future<void> savePlan(Map<String, dynamic> plan);
  Future<void> logout();
}
