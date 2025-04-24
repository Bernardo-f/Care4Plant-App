import '../repositories/reporte_diario_repository.dart';

class GetReporteDiarioUseCase {
  final ReporteDiarioRepository _reporteDiarioRepository;

  GetReporteDiarioUseCase(this._reporteDiarioRepository);

  Future<int?> call() async {
    return _reporteDiarioRepository.getReporteDiario();
  }
}
