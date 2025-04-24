import '../repositories/user_repository.dart';

class GetSemanaFrecuenciaTestUseCase {
  final UserRepository _repository;

  GetSemanaFrecuenciaTestUseCase(this._repository);

  Future<int?> call() async {
    try {
      final result = await _repository.getSemanaFrecuenciaTest();
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
