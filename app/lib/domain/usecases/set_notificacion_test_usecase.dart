import 'package:care4plant/domain/repositories/user_repository.dart';

class SetNotificacionTestUseCase {
  final UserRepository repository;

  SetNotificacionTestUseCase(this.repository);

  Future<void> call(bool value) async {
    try {
      await repository.setNotificacionTest(value);
    } catch (e) {
      rethrow;
    }
  }
}
