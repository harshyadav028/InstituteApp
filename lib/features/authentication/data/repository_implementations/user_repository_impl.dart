import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../data_sources/user_data_sources.dart';

class UserRepositoryImpl implements UserRepository {
  final UhlUsersDB authDatabase;
  UserRepositoryImpl(this.authDatabase);

  @override
  Future<UserEntity?> signInUser(String email, String password) async {
    final user = await authDatabase.getUserByEmailAndPassword(email, password);
    if (user != null) {
      return UserEntity(
          id: user.id,
          name: user.name,
          email: user.email,
          password: user.password,
          image: user.image);
    } else {
      return null;
    }
  }

  @override
  Future<bool?> updatePassword(String id, String password) async {
    return await authDatabase.updatePassword(id, password);
  }

  @override
  Future<UserEntity?> getUserByEmail(String email) async {
    final user = await authDatabase.getUserByEmail(email);
    if (user.isNotEmpty) {
      return UserEntity(
          id: user.first.id,
          name: user.first.name,
          email: user.first.email,
          password: user.first.password,
          image: user.first.image);
    } else {
      return null;
    }
  }
}
