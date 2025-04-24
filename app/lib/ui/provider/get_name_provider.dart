import 'package:flutter/material.dart';

import '../../domain/usecases/get_name_usecase.dart';

class GetNameProvider extends ChangeNotifier {
  final GetNameUseCase getNameUseCase;

  GetNameProvider({required this.getNameUseCase});

  String? _name;
  String? get name => _name;

  bool _loading = false;
  bool get isLoading => _loading;

  String? _error;
  String? get error => _error;

  Future<void> init() async {
    _loading = true;
    notifyListeners();

    try {
      _name = await getNameUseCase.call();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
