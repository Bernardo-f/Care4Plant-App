import 'package:care4plant/domain/repositories/user_repository.dart';

class LogoutUseCase {
  final UserRepository _repository;

  LogoutUseCase(this._repository);

  Future<bool?> call() async {
    try {
      await _repository.logout();
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
