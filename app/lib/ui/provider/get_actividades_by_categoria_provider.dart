import 'package:care4plant/models/actividad.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/get_actvidades_by_categoria_usecase.dart';

enum GetActividadesByCategoriaState { idle, loading, loaded, error }

class GetActividadesByCategoriaProvider extends ChangeNotifier {
  final GetActividadesByCategoriaUseCase getActividadesByCategoriaUseCase;

  GetActividadesByCategoriaProvider({required this.getActividadesByCategoriaUseCase});

  List<Actividad>? _actividades;
  List<Actividad>? get actividades => _actividades;

  GetActividadesByCategoriaState _state = GetActividadesByCategoriaState.idle;

  GetActividadesByCategoriaState get state => _state;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> init(int idCategoria) async {
    try {
      _state = GetActividadesByCategoriaState.loading;
      notifyListeners();
      _actividades = await getActividadesByCategoriaUseCase.call(idCategoria);
      _state = GetActividadesByCategoriaState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = GetActividadesByCategoriaState.error;
    } finally {
      notifyListeners();
    }
  }
}
