import 'package:flutter/material.dart';

import '../../domain/usecases/get_categorias_recomendadas_usecase.dart';
import '../../models/recomendacion.dart';

enum GetCategoriasRecomendadasState {
  idle,
  loading,
  success,
  error,
}

class GetCategoriasRecomendadasProvider extends ChangeNotifier {
  final GetCategoriasRecomendadasUseCase getCategoriasRecomendadasUseCase;
  late List<Recomendacion> _categoriasRecomendadas;
  List<Recomendacion> get categoriasRecomendadas => _categoriasRecomendadas;
  GetCategoriasRecomendadasState _state = GetCategoriasRecomendadasState.idle;
  GetCategoriasRecomendadasState get state => _state;

  GetCategoriasRecomendadasProvider({required this.getCategoriasRecomendadasUseCase});

  Future<void> init() async {
    try {
      _state = GetCategoriasRecomendadasState.loading;
      notifyListeners();
      _categoriasRecomendadas = await getCategoriasRecomendadasUseCase.call();
      _state = GetCategoriasRecomendadasState.success;
    } catch (e) {
      _state = GetCategoriasRecomendadasState.error;
    } finally {
      notifyListeners();
    }
  }
}
