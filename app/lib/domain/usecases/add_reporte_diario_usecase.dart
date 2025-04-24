import '../../models/reporte_diario.dart';
import '../repositories/reporte_diario_repository.dart';

class AddReporteDiarioUseCase {
  final ReporteDiarioRepository _reporteDiarioRepository;

  AddReporteDiarioUseCase(this._reporteDiarioRepository);

  Future<void> call(ReporteDiario reporteDiario) async {
    try {
      await _reporteDiarioRepository.addReporteDiario(reporteDiario);
      await _reporteDiarioRepository.addLocalReporteDiario(reporteDiario.estado_reporte);
    } catch (e) {
      rethrow;
    }
  }
}
