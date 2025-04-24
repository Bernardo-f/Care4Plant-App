import 'package:care4plant/domain/repositories/user_repository.dart';

class GetAccesoInvernaderoUseCase {
  final UserRepository _repository;

  GetAccesoInvernaderoUseCase(this._repository);

  Future<bool?> call() async {
    try {
      final result = await _repository.getAccesoInvernadero();
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
