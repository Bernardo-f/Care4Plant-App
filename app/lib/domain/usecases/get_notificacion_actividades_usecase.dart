import 'package:care4plant/domain/repositories/user_repository.dart';

class GetNotificacionActividadesUseCase {
  final UserRepository _repository;

  GetNotificacionActividadesUseCase(this._repository);

  Future<bool?> call() async {
    try {
      final result = await _repository.getNotificacionActividades();
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
