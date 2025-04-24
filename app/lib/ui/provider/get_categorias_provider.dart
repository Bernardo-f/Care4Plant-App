import 'package:flutter/widgets.dart';

import '../../domain/usecases/get_categorias_usecase.dart';
import '../../models/categoria.dart';

enum GetCategoriasState {
  idle,
  loading,
  success,
  error,
}

class GetCategoriasProvider extends ChangeNotifier {
  final GetCategoriasUseCase getCategoriasUseCase;

  late List<Categoria> _categorias;

  List<Categoria> get categorias => _categorias;

  GetCategoriasState _state = GetCategoriasState.idle;
  GetCategoriasState get state => _state;

  GetCategoriasProvider({required this.getCategoriasUseCase});

  Future<void> init() async {
    try {
      _state = GetCategoriasState.loading;
      notifyListeners();
      _categorias = await getCategoriasUseCase.call() ?? [];
      _state = GetCategoriasState.success;
    } catch (e) {
      _state = GetCategoriasState.error;
    } finally {
      notifyListeners();
    }
  }
}
