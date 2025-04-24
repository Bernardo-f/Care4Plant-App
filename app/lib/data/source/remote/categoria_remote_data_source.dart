import 'dart:convert';

import 'package:care4plant/core/error/server_exception.dart';
import '../../../core/services/network/custom_http_client.dart';
import '../../../env.dart';
import '../../../models/categoria.dart';

class CategoriaRemoteDataSource {
  // This class will handle the remote data source for categories
  // It will interact with an API or a database to fetch category data
  // For now, we can leave it empty or add some placeholder methods
  final CustomHttpClient client;

  CategoriaRemoteDataSource(this.client);

  Future<List<Categoria>?> getAll(String acceptLanguage) async {
    try {
      final response = await client.get('$apiUrl/api/categoria/getall');
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
        List<Categoria> categoriaList =
            parsed.map<Categoria>((json) => Categoria.fromJson(json)).toList();
        return categoriaList;
      } else {
        throw ServerException(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }
}
