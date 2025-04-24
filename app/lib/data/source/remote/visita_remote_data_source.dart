import '../../../core/error/server_exception.dart';
import '../../../core/services/network/custom_http_client.dart';
import '../../../env.dart';
import '../../../models/visita.dart';

class VisitaRemoteDataSource {
  final CustomHttpClient client;

  VisitaRemoteDataSource(this.client);
  // This class will handle

  Future<void> addVisita(Visita visita) async {
    try {
      final response = await client.post(
        '$apiUrl/api/Visita/AddVisitaCategoria',
        body: visita.toMap(),
      );
      if (response.statusCode != 200) {
        throw ServerException('Error al agregar la visita');
      }
    } catch (e) {
      rethrow;
    }
  }
}
