
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> register(String email, String password, String name);
  Future<UserEntity?> login(String email, String password);
  Future<UserEntity?> loginWithGoogle();
  Future<void> logout();
  Future<void> sendPasswordResetEmail(String email);
  UserEntity? get currentUser;
}
