import 'package:care4plant/domain/entities/validate_session_entity.dart';
import 'package:care4plant/domain/usecases/validate_session_usecase.dart';
import 'package:flutter/material.dart';

enum ValidateSessionState { idle, loading, loaded, error, login, stressLevelTest, home }

class ValidateSessionProvider extends ChangeNotifier {
  final ValidateSessionUseCase validateSessionUseCase;
  ValidateSessionEntity? validateSessionEntity;

  ValidateSessionProvider({required this.validateSessionUseCase});

  ValidateSessionState _state = ValidateSessionState.idle;

  ValidateSessionState get state => _state;

  void setState(ValidateSessionState state) {
    _state = state;
    notifyListeners();
  }

  Future<void> validateSession() async {
    setState(_state = ValidateSessionState.loading);
    try {
      final validateSession = await validateSessionUseCase.call();
      if (validateSession.firstLogin) {
        // Navigate to first login screen
        setState(_state = ValidateSessionState.login);
      } else if (validateSession.firstStressLevelTest) {
        // Navigate to stress level test screen
        setState(_state = ValidateSessionState.stressLevelTest);
      } else {
        // Navigate to home screen
        setState(_state = ValidateSessionState.home);
      }
    } catch (e) {
      setState(_state = ValidateSessionState.error);
    }
  }
}
