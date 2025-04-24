import 'package:care4plant/domain/usecases/get_name_usecase.dart';
import 'package:care4plant/domain/usecases/get_plant_by_stress_level.dart';
import 'package:flutter/material.dart';

class NameAndPlantProvider extends ChangeNotifier {
  final GetNameUseCase getNameUseCase;
  final GetPlantByStressLevelUseCase getPlantByStressLevelUseCase;

  NameAndPlantProvider(
    this.getNameUseCase,
    this.getPlantByStressLevelUseCase,
  );

  String? _name;
  String? get name => _name;

  String? _plant;
  String? get plant => _plant;

  void init() async {
    _name = await getNameUseCase.call();
    _plant = await getPlantByStressLevelUseCase.call();
    notifyListeners();
  }
}
