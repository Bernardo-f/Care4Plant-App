import 'package:flutter/material.dart';

import '../../domain/usecases/get_stress_level_usecase.dart';

class GetStressLeveProvider extends ChangeNotifier {
  final GetStressLevelUseCase getStressLevelUseCase;

  GetStressLeveProvider({required this.getStressLevelUseCase});

  int? _name;
  int? get name => _name;

  bool _loading = false;
  bool get isLoading => _loading;

  String? _error;
  String? get error => _error;

  Future<void> init() async {
    _loading = true;
    notifyListeners();

    try {
      _name = await getStressLevelUseCase.call();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
