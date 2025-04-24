import 'package:care4plant/domain/repositories/user_repository.dart';

class SetFrecuenciaTestUseCase {
  final UserRepository repository;

  SetFrecuenciaTestUseCase(this.repository);

  Future<void> call(int semanaFrecuenciaTest, int frecuenciaTest) async {
    try {
      await repository.setFrecuenciaTest(semanaFrecuenciaTest, frecuenciaTest);
    } catch (e) {
      rethrow;
    }
  }
}
