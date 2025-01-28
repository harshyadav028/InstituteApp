import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity?> signInUser(String email, String password);
  Future<bool?> updatePassword(String id, String password);
  Future<UserEntity?> getUserByEmail(String email);
}