import '../../models/reporte_diario.dart';

abstract class ReporteDiarioRepository {
  Future<bool> addReporteDiario(ReporteDiario reporteDiario);
  Future<void> addLocalReporteDiario(int estadoReporte);
  Future<int?> getReporteDiario();
}
