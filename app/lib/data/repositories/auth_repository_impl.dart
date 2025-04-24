import 'package:care4plant/data/models/validate_session_model.dart';
import 'package:care4plant/data/source/remote/auth_remote_data_source.dart';
import 'package:care4plant/domain/entities/validate_session_entity.dart';
import 'package:care4plant/domain/repositories/auth_repository.dart';
import 'package:care4plant/models/user_register.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<ValidateSessionEntity> validateSession() async {
    try {
      final response = await _authRemoteDataSource.validateSession();
      return _mapModelToEntity(response);
    } catch (e) {
      throw Exception('Error al validar la sesión');
    }
  }

  @override
  Future<dynamic> login(String email, String password) async {
    try {
      return await _authRemoteDataSource.login(email, password);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> signUp(UserRegister userRegister) async {
    try {
      return await _authRemoteDataSource.signUp(userRegister);
    } catch (e) {
      rethrow;
    }
  }
}

ValidateSessionEntity _mapModelToEntity(ValidateSessionModel model) {
  return ValidateSessionEntity(
    firstLogin: model.firstLogin,
    firstStressLevelTest: model.firstStressLevelTest,
  );
}
