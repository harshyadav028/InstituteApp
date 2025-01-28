import '../repositories/user_repository.dart';

class UpdatePassword {
  final UserRepository repository;

  UpdatePassword(this.repository);

  Future<bool?> execute(String id, String password) {
    return repository.updatePassword(id, password);
  }
}
