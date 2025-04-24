import 'package:care4plant/models/stress_test.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/register_stress_test_usecase.dart';

enum RegisterStressTestState { idle, loading, loaded, error, success }

class RegisterStressTestProvider extends ChangeNotifier {
  final RegisterStressTestUseCase registerStressTestUseCase;

  RegisterStressTestProvider({required this.registerStressTestUseCase});

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  RegisterStressTestState _state = RegisterStressTestState.idle;

  RegisterStressTestState get state => _state;

  void setState(RegisterStressTestState state) {
    _state = state;
    notifyListeners();
  }

  void registerTest(Stresstest stresstest) async {
    setState(RegisterStressTestState.loading);
    try {
      await registerStressTestUseCase.call(stresstest);
      setState(RegisterStressTestState.success);
    } catch (e) {
      _errorMessage = e.toString();
      setState(RegisterStressTestState.error);
    }
  }

  void resetState() {
    _state = RegisterStressTestState.idle;
    notifyListeners();
  }
}
