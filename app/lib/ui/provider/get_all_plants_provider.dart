import 'package:flutter/material.dart';

import '../../domain/usecases/getall_plants_usecase.dart';
import '../../models/plant.dart';

enum GetAllPlantsState {
  idle,
  loading,
  success,
  error,
}

class GetAllPlantsProvider extends ChangeNotifier {
  final List<Plant> _plants = [];
  final GetAllPlantsUseCase _getAllPlantsUseCase;

  GetAllPlantsProvider(this._getAllPlantsUseCase);

  GetAllPlantsState _state = GetAllPlantsState.idle;

  GetAllPlantsState get state => _state;

  List<Plant> get plants => _plants;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  void setState(GetAllPlantsState state) {
    _state = state;
    notifyListeners();
  }

  void resetState() {
    _state = GetAllPlantsState.idle;
    notifyListeners();
  }

  Future<void> getAllPlants() async {
    setState(GetAllPlantsState.loading);
    try {
      final response = await _getAllPlantsUseCase.call();
      _plants.clear();
      _plants.addAll(response);
      setState(GetAllPlantsState.success);
    } catch (e) {
      _errorMessage = e.toString();
      setState(GetAllPlantsState.error);
    }
  }
}
