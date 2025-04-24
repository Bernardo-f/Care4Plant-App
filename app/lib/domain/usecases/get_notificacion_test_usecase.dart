import 'package:care4plant/domain/repositories/user_repository.dart';

class GetNotificacionTestUseCase {
  // This class is a placeholder for the actual implementation of the use case.
  // It should contain methods to interact with the repository and fetch notifications.

  final UserRepository _repository;

  GetNotificacionTestUseCase(this._repository);

  Future<bool?> call() async {
    try {
      final result = await _repository.getNotificacionTest();
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
