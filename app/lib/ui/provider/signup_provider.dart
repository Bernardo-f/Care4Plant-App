import 'package:care4plant/domain/usecases/signup_usecase.dart';
import 'package:care4plant/models/user_register.dart';
import 'package:flutter/material.dart';

enum SignUpState { idle, loading, loaded, error }

class SignUpProvider extends ChangeNotifier {
  final SignUpUseCase signUpUseCase;
  SignUpState _state = SignUpState.idle;
  String? _errorMessage;

  SignUpProvider({required this.signUpUseCase});

  SignUpState get state => _state;
  String? get errorMessage => _errorMessage;

  void setState(SignUpState state) {
    _state = state;
    notifyListeners();
  }

  void resetState() {
    _state = SignUpState.idle;
    notifyListeners();
  }

  Future<void> signUp(UserRegister userRegister) async {
    setState(_state = SignUpState.loading);
    try {
      final res = await signUpUseCase.call(userRegister);
      _errorMessage = res;
      setState(_state = SignUpState.loaded);
    } catch (e) {
      _errorMessage = e.toString();
      setState(_state = SignUpState.error);
    }
  }
}
