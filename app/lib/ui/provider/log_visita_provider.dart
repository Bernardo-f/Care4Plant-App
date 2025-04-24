import 'package:care4plant/domain/usecases/log_visita_usecase.dart';
import 'package:care4plant/models/visita.dart';

class LogVisitaProvider {
  LogVisitaUseCase logVisitaUseCase;
  LogVisitaProvider({required this.logVisitaUseCase});

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
  }

  void setErrorMessage(String? errorMessage) {
    _errorMessage = errorMessage;
  }

  Future<void> logVisita(Visita visita) async {
    setLoading(true);
    try {
      await logVisitaUseCase.call(visita);
      setLoading(false);
    } catch (e) {
      setErrorMessage(e.toString());
      setLoading(false);
    }
  }
}
