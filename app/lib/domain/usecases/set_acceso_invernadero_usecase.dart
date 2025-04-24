import 'package:care4plant/domain/repositories/user_repository.dart';

class SetAccesoInvernaderoUseCase {
  final UserRepository repository;

  SetAccesoInvernaderoUseCase(this.repository);

  Future<void> call(bool value) async {
    try {
      await repository.setAccesoInvernadero(value);
    } catch (e) {
      rethrow;
    }
  }
}
