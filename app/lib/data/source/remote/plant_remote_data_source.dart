import 'dart:convert';

import 'package:care4plant/core/error/server_exception.dart';
import 'package:care4plant/models/plant.dart';

import '../../../core/services/network/custom_http_client.dart';
import '../../../env.dart';

class PlantRemoteDataSource {
  final CustomHttpClient client;

  PlantRemoteDataSource(this.client);

  Future<List<Plant>> getall() async {
    try {
      final response = await client.get('$apiUrl/api/plant/GetAll');
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
        return parsed.map<Plant>((json) => Plant.fromJson(json)).toList();
      } else {
        throw ServerException(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }
}
