import 'dart:convert';

import 'package:care4plant/models/page_greenhouse.dart';
import 'package:care4plant/models/pensamiento.dart';

import '../../../core/services/network/custom_http_client.dart';
import '../../../env.dart';
import '../../../models/user_greenhouse.dart';

class GreenhouseRemoteDataSource {
  final CustomHttpClient client;

  GreenhouseRemoteDataSource(this.client);

  Future<void> addPensamiento(Pensamiento pensamiento) async {
    try {
      final response = await client.post(
        '$apiUrl/api/pensamiento/add',
        body: pensamiento.toMap(),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to add pensamiento');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Pensamiento>?> getPensamientos(String? email) async {
    try {
      final query = (email != null) ? "?Email=$email" : "";
      final response = await client.get('$apiUrl/api/pensamiento/GetPensamientos$query');
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
        List<Pensamiento> pensamientos =
            parsed.map<Pensamiento>((json) => Pensamiento.fromJson(json)).toList();
        return pensamientos;
      } else {
        throw Exception('Failed to load pensamientos');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> meGusta(String? emailEmisor, DateTime fechaPensamiento) async {
    try {
      final Map<String, dynamic> requestData = (emailEmisor != null)
          ? {
              'email_emisor': emailEmisor.toString(),
              'fecha_pensamiento': fechaPensamiento.toUtc().toIso8601String().toString(),
            }
          : {
              'fecha_pensamiento': fechaPensamiento.toUtc().toIso8601String().toString(),
            };
      final response = await client.postForm(
        '$apiUrl/api/pensamiento/MeGusta',
        body: requestData,
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to like pensamiento');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<PageGreenhouse> getUsers(int page) async {
    try {
      final response = await client.get(
        '$apiUrl/api/pensamiento/GetUser?page=$page',
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final parsed = json['usersGreenhouse'] as List;
        List<UserGreenhouse> userGreenhouseList =
            parsed.map<UserGreenhouse>((json) => UserGreenhouse.fromJson(json)).toList();
        final pageGreenhouse =
            PageGreenhouse(nextPage: json['nextPage'], usersGreenhouse: userGreenhouseList);
        return pageGreenhouse;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      rethrow;
    }
  }
}
