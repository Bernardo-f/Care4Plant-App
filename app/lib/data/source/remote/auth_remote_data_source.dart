import 'dart:convert';

import 'package:care4plant/core/error/server_exception.dart';
import 'package:care4plant/core/services/network/custom_http_client.dart';
import 'package:care4plant/data/models/validate_session_model.dart';
import 'package:care4plant/env.dart';
import 'package:care4plant/models/user_register.dart';

class AuthRemoteDataSource {
  final CustomHttpClient client;

  AuthRemoteDataSource(this.client);

  Future<ValidateSessionModel> validateSession() async {
    try {
      final response = await client.get('$apiUrl/api/auth/ValidateToken');

      if (response.statusCode == 200) {
        return ValidateSessionModel.fromJson(response.body);
      } else {
        throw Exception('Token inválido o expirado');
      }
    } catch (e) {
      throw Exception('Error al validar la sesión: $e');
    }
  }

  Future<dynamic> login(String email, String password) async {
    try {
      final response =
          await client.post('$apiUrl/api/auth/login', body: {'email': email, 'password': password});

      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);
        return res;
      } else {
        throw ServerException(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> signUp(UserRegister userRegister) async {
    try {
      final response = await client.post('$apiUrl/api/auth/register', body: userRegister.toMap());

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw ServerException(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }
}
