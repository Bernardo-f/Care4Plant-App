import '../../domain/repositories/reporte_diario_repository.dart';
import '../../models/reporte_diario.dart';
import '../source/local/reporte_diario_local_data_source.dart';
import '../source/remote/reporte_diario_remote_data_source.dart';

class ReporteDiarioRepositoryImpl extends ReporteDiarioRepository {
  final ReporteDiarioRemoteDataSource _reporteDiarioRemoteDataSource;
  final ReporteDiarioLocalDataSource _reporteDiarioLocalDataSource;

  ReporteDiarioRepositoryImpl(
      this._reporteDiarioRemoteDataSource, this._reporteDiarioLocalDataSource);

  @override
  Future<bool> addReporteDiario(ReporteDiario reporteDiario) async {
    try {
      final response = await _reporteDiarioRemoteDataSource.addReporteDiario(reporteDiario);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int?> getReporteDiario() async {
    try {
      final response = await _reporteDiarioLocalDataSource.getReporteDiario();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addLocalReporteDiario(int estadoReporte) async {
    try {
      await _reporteDiarioLocalDataSource.addLocalReporteDiario(estadoReporte);
    } catch (e) {
      rethrow;
    }
  }
}
