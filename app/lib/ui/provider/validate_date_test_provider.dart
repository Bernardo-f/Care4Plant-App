import 'package:flutter/material.dart';

import '../../domain/usecases/validate_date_test_usecase.dart';

enum ValidateDateTestState { idle, loading, loaded, error }

class ValidateDateTestProvider extends ChangeNotifier {
  final ValidateDateTestUseCase validateDateTestUseCase;
  ValidateDateTestProvider({required this.validateDateTestUseCase});

  bool? _isValidDateTest;
  bool? get isValidDateTest => _isValidDateTest;

  ValidateDateTestState _state = ValidateDateTestState.idle;
  ValidateDateTestState get state => _state;

  Future<void> init() async {
    _state = ValidateDateTestState.loading;
    try {
      _isValidDateTest = await validateDateTestUseCase.call();
      if (_isValidDateTest == null) {
        _state = ValidateDateTestState.error;
      } else {
        _state = ValidateDateTestState.loaded;
      }
    } catch (e) {
      _state = ValidateDateTestState.error;
      _isValidDateTest = false;
    } finally {
      notifyListeners();
    }
  }
}
