import '../repositories/user_repository.dart';

class ValidateDateTestUseCase {
  final UserRepository userRepository;

  ValidateDateTestUseCase(this.userRepository);

  Future<bool> call() async {
    try {
      final response = await userRepository.validateDateTest();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
