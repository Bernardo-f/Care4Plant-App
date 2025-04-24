import 'package:care4plant/domain/repositories/auth_repository.dart';
import 'package:care4plant/models/user_register.dart';

class SignUpUseCase {
  final AuthRepository _repository;

  SignUpUseCase(this._repository);

  Future<dynamic> call(UserRegister userRegister) async {
    try {
      final response = await _repository.signUp(userRegister);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
