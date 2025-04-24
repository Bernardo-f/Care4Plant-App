import 'package:flutter/material.dart';
import 'package:care4plant/domain/usecases/login_usecase.dart';

enum LoginState { idle, loading, loaded, error, redirectOnboarding, redirectStressTest }

class LoginProvider extends ChangeNotifier {
  final LoginUseCase loginUseCase;

  LoginProvider({required this.loginUseCase});

  LoginState _state = LoginState.idle;

  LoginState get state => _state;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  void setState(LoginState state) {
    _state = state;
    notifyListeners();
  }

  /// Resetea el estado del provider a su estado inicial.
  void resetState() {
    _state = LoginState.idle;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    setState(_state = LoginState.loading);
    try {
      final loginResponse = await loginUseCase.call(email, password);
      if (loginResponse['user']['first_login']) {
        // Vamos a la pantalla de onboarding
        // Navigate to first login screen
        setState(_state = LoginState.redirectOnboarding);
      } else if (!loginResponse['haveStressTest']) {
        setState(_state = LoginState.redirectStressTest);
      } else {
        setState(_state = LoginState.loaded);
      }
    } catch (e) {
      _errorMessage = e.toString();
      setState(_state = LoginState.error);
    }
  }
}
