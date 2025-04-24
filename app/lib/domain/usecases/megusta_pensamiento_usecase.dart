import 'package:care4plant/domain/repositories/greenhouse_repository.dart';

class MegustaPensamientoUseCase {
  final GreenhouseRepository _repository;

  MegustaPensamientoUseCase(this._repository);

  Future<bool> call(String? emailEmisor, DateTime fechaPensamiento) async {
    try {
      final result = await _repository.meGusta(emailEmisor, fechaPensamiento);
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
