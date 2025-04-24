import 'package:care4plant/domain/usecases/add_ingreso_actividad_usecase.dart';
import 'package:flutter/material.dart';

enum AddIngresoActividadState { idle, loading, loaded, error, success }

class AddIngresoActividadProvider extends ChangeNotifier {
  final AddIngresoActividadUseCase addIngresoActividadUseCase;

  AddIngresoActividadProvider({required this.addIngresoActividadUseCase});

  String? _message;
  String? get message => _message;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  AddIngresoActividadState _state = AddIngresoActividadState.idle;
  AddIngresoActividadState get state => _state;

  Future<void> addIngresoActividad(int idActividad, bool finalizada) async {
    _state = AddIngresoActividadState.loading;
    notifyListeners();
    try {
      _message = await addIngresoActividadUseCase.call(idActividad, finalizada);
      _state = AddIngresoActividadState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = AddIngresoActividadState.error;
    } finally {
      if (finalizada == true) {
        notifyListeners();
      }
    }
  }
}
