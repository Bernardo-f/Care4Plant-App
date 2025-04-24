// plant_provider.dart
import 'dart:async';

import 'package:care4plant/domain/usecases/get_plant_usecase.dart';
import 'package:care4plant/models/accesorio.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/get_accesorios_usecase.dart';
import '../../domain/usecases/get_stress_level_usecase.dart';
import '../../domain/usecases/usar_accesorio_usecase.dart';

class PlantProvider extends ChangeNotifier {
  final GetAccesoriosUseCase getAccesoriosUseCase;
  final GetStressLevelUseCase getStressLevelUseCase;
  final GetPlantUseCase getPlantUseCase;
  final UsarAccesorioUseCase usarAccesorioUseCase;
  int _pageAccesorios = 1;
  int _animacionAccesorio = -1;
  List<Accesorio>? _accesorios;
  String? _plant;
  int? _stressLevel;
  Timer? _timer;

  PlantProvider({
    required this.getAccesoriosUseCase,
    required this.getStressLevelUseCase,
    required this.usarAccesorioUseCase,
    required this.getPlantUseCase,
  });

  int get pageAccesorios => _pageAccesorios;
  int get animacionAccesorio => _animacionAccesorio;
  String? get plant => _plant;
  int? get stressLevel => _stressLevel;
  List<Accesorio>? get accesorios => _accesorios;

  Future<void> init() async {
    _plant = await getPlantUseCase.call();
    _accesorios = await getAccesoriosUseCase.call();
    _stressLevel = await getStressLevelUseCase.call();
    notifyListeners();
  }

  Future<void> playAnimation(int id) async {
    if (_stressLevel == 0) return;
    try {
      await usarAccesorioUseCase.call(id);
      _accesorios = await getAccesoriosUseCase.call();
      _stressLevel = await getStressLevelUseCase.call();
      _plant = await getPlantUseCase.call();
      _animacionAccesorio = id;
      _timer?.cancel();
      _timer = Timer(const Duration(seconds: 5), () {
        _animacionAccesorio = -1;
        notifyListeners();
      });
      notifyListeners();
    } catch (e) {
      return;
    }
  }

  void nextPage() {
    _pageAccesorios++;
    notifyListeners();
  }

  void previousPage() {
    if (_pageAccesorios > 1) {
      _pageAccesorios--;
      notifyListeners();
    }
  }
}
