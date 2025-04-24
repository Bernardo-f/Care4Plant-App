import 'package:care4plant/domain/entities/validate_session_entity.dart';
import 'package:care4plant/models/user_register.dart';

abstract class AuthRepository {
  Future<ValidateSessionEntity> validateSession();
  Future<dynamic> login(String email, String password);
  Future<dynamic> signUp(UserRegister userRegister);
}
