import 'package:flutter/material.dart';

import '../../domain/usecases/get_reporte_diario_usecase.dart';

class GetReporteDiarioProvider extends ChangeNotifier {
  final GetReporteDiarioUseCase getReporteDiarioUseCase;

  GetReporteDiarioProvider({required this.getReporteDiarioUseCase});

  int? _reporteDiario;
  int? get reporteDiario => _reporteDiario;

  bool _loading = false;
  bool get isLoading => _loading;

  String? _error;
  String? get error => _error;

  Future<void> init() async {
    _loading = true;
    notifyListeners();

    try {
      _reporteDiario = await getReporteDiarioUseCase.call();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
