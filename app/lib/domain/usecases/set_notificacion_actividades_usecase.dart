import 'package:care4plant/domain/repositories/user_repository.dart';

class SetNotificacionActividadesUseCase {
  final UserRepository repository;

  SetNotificacionActividadesUseCase(this.repository);

  Future<void> call(bool value) async {
    try {
      await repository.setNotificacionActividades(value);
    } catch (e) {
      rethrow;
    }
  }
}
