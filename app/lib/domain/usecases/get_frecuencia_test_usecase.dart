import 'package:care4plant/domain/repositories/user_repository.dart';

class GetFrecuenciaTestUseCase {
  final UserRepository repository;

  GetFrecuenciaTestUseCase(this.repository);

  Future<int?> call() async {
    try {
      final result = await repository.getFrecuenciaTest();
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
