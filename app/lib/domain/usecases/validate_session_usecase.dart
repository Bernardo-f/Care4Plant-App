import 'package:care4plant/domain/entities/validate_session_entity.dart';
import 'package:care4plant/domain/repositories/auth_repository.dart';

class ValidateSessionUseCase {
  final AuthRepository _authRepository;

  ValidateSessionUseCase(this._authRepository);

  Future<ValidateSessionEntity> call() async {
    return await _authRepository.validateSession();
  }
}
