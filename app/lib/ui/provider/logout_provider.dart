import '../../domain/usecases/logout_usecase.dart';

class LogoutProvider {
  final LogoutUseCase _logoutUseCase;

  LogoutProvider(this._logoutUseCase);

  Future<bool> logout() async {
    try {
      await _logoutUseCase.call();
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
