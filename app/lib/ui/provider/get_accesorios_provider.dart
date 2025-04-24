import 'package:care4plant/models/accesorio.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/get_accesorios_usecase.dart';

class GetAccesoriosProvider extends ChangeNotifier {
  final GetAccesoriosUseCase getAccesoriosUseCase;

  GetAccesoriosProvider({required this.getAccesoriosUseCase});

  List<Accesorio>? _accesorios;
  List<Accesorio>? get accesorios => _accesorios;

  bool _loading = false;
  bool get isLoading => _loading;

  String? _error;
  String? get error => _error;

  Future<void> init() async {
    _loading = true;
    notifyListeners();

    try {
      _accesorios = await getAccesoriosUseCase.call();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
