import 'package:care4plant/domain/usecases/get_usuarios_greenhouse_usecase.dart';
import 'package:care4plant/models/page_greenhouse.dart';
import 'package:flutter/material.dart';

enum CuidadoresGreenhouseProviderState {
  idle,
  loading,
  success,
  error,
}

class CuidadoresGreenhouseProvider extends ChangeNotifier {
  final GetUsuariosGreenhouseUseCase getUsuariosGreenhouseUseCase;

  CuidadoresGreenhouseProvider(this.getUsuariosGreenhouseUseCase);

  CuidadoresGreenhouseProviderState _state = CuidadoresGreenhouseProviderState.idle;

  CuidadoresGreenhouseProviderState get state => _state;

  int _page = 0;
  int get page => _page;

  PageGreenhouse? _pageGreenhouse;
  PageGreenhouse? get pageGreenhouse => _pageGreenhouse;

  void init() async {
    try {
      _state = CuidadoresGreenhouseProviderState.loading;
      _pageGreenhouse = await getUsuariosGreenhouseUseCase.call(_page);
      _state = CuidadoresGreenhouseProviderState.success;
    } catch (e) {
      _state = CuidadoresGreenhouseProviderState.error;
    } finally {
      notifyListeners();
    }
  }

  void changePage(int page) async {
    try {
      _state = CuidadoresGreenhouseProviderState.loading;
      _page = page;
      _pageGreenhouse = await getUsuariosGreenhouseUseCase.call(_page);
      _state = CuidadoresGreenhouseProviderState.success;
    } catch (e) {
      _state = CuidadoresGreenhouseProviderState.error;
    } finally {
      notifyListeners();
    }
  }
}
