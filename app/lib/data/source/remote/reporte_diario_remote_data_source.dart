import '../../../core/services/network/custom_http_client.dart';
import '../../../env.dart';
import '../../../models/reporte_diario.dart';

class ReporteDiarioRemoteDataSource {
  final CustomHttpClient client;

  ReporteDiarioRemoteDataSource(this.client);

  Future<bool> addReporteDiario(ReporteDiario reporteDiario) async {
    try {
      final response =
          await client.post('$apiUrl/api/reportediario/add', body: reporteDiario.toMap());
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Error al agregar el reporte diario: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error al agregar el reporte diario: $e');
    }
  }
}
