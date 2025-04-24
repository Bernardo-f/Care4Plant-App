import 'package:care4plant/domain/usecases/add_reporte_diario_usecase.dart';
import 'package:care4plant/domain/usecases/get_reporte_diario_usecase.dart';
import 'package:care4plant/models/reporte_diario.dart';
import 'package:flutter/foundation.dart';

enum ReporteDiarioState { idle, loading, loaded, error, success }

class ReporteDiarioProvider extends ChangeNotifier {
  final GetReporteDiarioUseCase getReporteDiarioUseCase;
  final AddReporteDiarioUseCase addReporteDiarioUseCase;

  ReporteDiarioProvider({
    required this.getReporteDiarioUseCase,
    required this.addReporteDiarioUseCase,
  });

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  ReporteDiarioState _state = ReporteDiarioState.idle;
  ReporteDiarioState get state => _state;

  int? _estadoReporte;
  int? get estadoReporte => _estadoReporte;

  void setState(ReporteDiarioState state) {
    _state = state;
    notifyListeners();
  }

  void init() {
    getReporteDiario();
  }

  void registerTest(int estadoReporte) async {
    setState(ReporteDiarioState.loading);
    try {
      await addReporteDiarioUseCase.call(ReporteDiario(estado_reporte: estadoReporte));
      getReporteDiario();
      setState(ReporteDiarioState.success);
    } catch (e) {
      _errorMessage = e.toString();
      setState(ReporteDiarioState.error);
    }
  }

  void getReporteDiario() async {
    setState(ReporteDiarioState.loading);
    try {
      final response = await getReporteDiarioUseCase.call();
      if (response != null) {
        _estadoReporte = response;
        setState(ReporteDiarioState.loaded);
      } else {
        _estadoReporte = response;
        setState(ReporteDiarioState.error);
      }
    } catch (e) {
      _errorMessage = e.toString();
      setState(ReporteDiarioState.error);
    }
  }
}
