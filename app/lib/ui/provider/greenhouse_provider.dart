import 'package:care4plant/models/pensamiento.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/add_pensamiento_usecase.dart';
import '../../domain/usecases/get_message_greenhouse_usecase.dart';
import '../../domain/usecases/get_plant_by_stress_level.dart';
import '../../domain/usecases/set_message_greenhouse_usecase.dart';

enum GreenhouseProviderState {
  idle,
  loading,
  success,
  error,
}

class GreenhouseProvider with ChangeNotifier {
  final AddPensamientoUseCase addPensamientoUseCase;
  final SetMessageGreenhouseUseCase setMessageGreenhouseUseCase;
  final GetMessageGreenhouseUseCase getMessageGreenhouseUseCase;
  final GetPlantByStressLevelUseCase getPlantByStressLevelUseCase;

  GreenhouseProvider(
    this.addPensamientoUseCase,
    this.setMessageGreenhouseUseCase,
    this.getMessageGreenhouseUseCase,
    this.getPlantByStressLevelUseCase,
  );

  GreenhouseProviderState _state = GreenhouseProviderState.idle;
  GreenhouseProviderState get state => _state;

  bool _showMessage = false;
  bool get showMessage => _showMessage;

  String? _plant;
  String? get plant => _plant;

  Future<void> init() async {
    try {
      _showMessage = await getMessageGreenhouseUseCase.call();
      _plant = await getPlantByStressLevelUseCase.call();
      notifyListeners();
    } catch (e) {}
  }

  Future<void> setMessage(bool value) async {
    try {
      await setMessageGreenhouseUseCase.call();
      _showMessage = value;
    } catch (e) {}
  }

  Future<void> resetState() async {
    _state = GreenhouseProviderState.idle;
    notifyListeners();
  }

  Future<void> addPensamiento(Pensamiento pensamiento) async {
    try {
      await addPensamientoUseCase.call(pensamiento);
      _state = GreenhouseProviderState.success;
      notifyListeners();
    } catch (e) {
      _state = GreenhouseProviderState.error;
      notifyListeners();
    }
  }
}
