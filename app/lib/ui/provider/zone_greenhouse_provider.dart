import 'package:care4plant/domain/usecases/get_name_usecase.dart';
import 'package:care4plant/domain/usecases/get_pensamientos_usecase.dart';
import 'package:care4plant/domain/usecases/get_plant_by_stress_level.dart';
import 'package:care4plant/domain/usecases/megusta_pensamiento_usecase.dart';
import 'package:care4plant/models/pensamiento.dart';
import 'package:flutter/material.dart';

enum ZoneGreenhouseProviderState {
  idle,
  loading,
  success,
  error,
}

class ZoneGreenhouseProvider with ChangeNotifier {
  final GetPensamientosUseCase getPensamientosUseCase;
  final MegustaPensamientoUseCase megustaPensamientoUseCase;
  final GetPlantByStressLevelUseCase getPlantByStressLevelUseCase;
  final GetNameUseCase getNameUseCase;

  ZoneGreenhouseProviderState _state = ZoneGreenhouseProviderState.idle;
  ZoneGreenhouseProviderState get state => _state;
  ZoneGreenhouseProvider(this.getPensamientosUseCase, this.megustaPensamientoUseCase,
      this.getPlantByStressLevelUseCase, this.getNameUseCase);

  List<Pensamiento> _pensamientos = [];
  List<Pensamiento> get pensamientos => _pensamientos;

  String? _plant;
  String? get plant => _plant;

  String? _name;
  String? get name => _name;

  Future<void> init(String? email) async {
    try {
      _state = ZoneGreenhouseProviderState.loading;
      _pensamientos = await getPensamientosUseCase.call(email) ?? [];
      _plant = await getPlantByStressLevelUseCase.call();
      _name = await getNameUseCase.call();
      notifyListeners();
      _state = ZoneGreenhouseProviderState.success;
    } catch (e) {
      _state = ZoneGreenhouseProviderState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> megustaPensamiento(String? emailEmisor, DateTime fechaPensamiento) async {
    try {
      notifyListeners();
      await megustaPensamientoUseCase.call(emailEmisor, fechaPensamiento);
    } catch (e) {
    } finally {
      notifyListeners();
    }
  }

  Future<void> refreshPensamientos(String? email) async {
    try {
      _pensamientos = await getPensamientosUseCase.call(email) ?? [];
    } catch (e) {
      _state = ZoneGreenhouseProviderState.error;
    } finally {
      notifyListeners();
    }
  }
}
