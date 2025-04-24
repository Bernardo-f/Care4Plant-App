import 'dart:convert';

import 'package:care4plant/core/error/server_exception.dart';
import 'package:care4plant/models/plant.dart';
import 'package:care4plant/models/user_settings.dart';

import '../../../core/services/network/custom_http_client.dart';
import '../../../env.dart';
import '../../../models/accesorio.dart';
import '../../../models/recomendacion.dart';

class UserRemoteDataSource {
  final CustomHttpClient client;

  UserRemoteDataSource(this.client);

  Future<Plant> saveSettings(UserSetting userSetting) async {
    try {
      final response =
          await client.post('$apiUrl/api/user/SaveBasicSettings', body: userSetting.toMap());

      if (response.statusCode == 200) {
        return Plant.fromJson(jsonDecode(response.body));
      } else {
        throw ServerException('Error al guardar la configuración del usuario');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Accesorio>?> getAccesorios() async {
    try {
      final response = await client.get(
        '$apiUrl/api/User/GetAccesorios',
      );
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
        List<Accesorio> accesorios =
            parsed.map<Accesorio>((json) => Accesorio.fromJson(json)).toList();
        return accesorios;
      } else {
        throw ServerException('Error al obtener los accesorios');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<int> usarAccesorio(int idAccesorio) async {
    try {
      final response = await client.post(
        '$apiUrl/api/user/UsarAccesorio?id_accesorio=$idAccesorio',
        body: {'id_accesorio': idAccesorio.toString()},
      );
      if (response.statusCode == 200) {
        return int.parse(response.body);
      } else {
        throw ServerException('Error al usar el accesorio');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> validateDateTest() async {
    try {
      final response = await client.get(
        '$apiUrl/api/User/ValidateDateTest?fechaDispositivo=${DateTime.now().toUtc().toIso8601String()}',
      );
      if (response.statusCode == 200) {
        return response.body == true.toString();
      } else {
        throw ServerException('Error al validar la fecha de la prueba');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Recomendacion>> getCategoriasRecomendadas() async {
    try {
      final response = await client.get(
        '$apiUrl/api/User/GetRecomendacion',
      );
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
        List<Recomendacion> categoriasRecomendadas =
            parsed.map<Recomendacion>((json) => Recomendacion.fromJson(json)).toList();
        return categoriasRecomendadas;
      } else {
        throw ServerException('Error al obtener las categorías recomendadas');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setNotificacionTest(bool value) async {
    try {
      final response =
          await client.postValue('$apiUrl/api/User/SetNotificacionTest', jsonEncode(value));
      if (response.statusCode != 200) {
        throw ServerException('Error al establecer la notificación de la prueba');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setNotificacionActividades(bool value) async {
    try {
      final response =
          await client.postValue('$apiUrl/api/User/SetNotificacionActividades', jsonEncode(value));
      if (response.statusCode != 200) {
        throw ServerException('Error al establecer la notificación de las actividades');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setAccesoInvernadero(bool value) async {
    try {
      final response =
          await client.postValue('$apiUrl/api/User/SetAccesoInvernadero', jsonEncode(value));
      if (response.statusCode != 200) {
        throw ServerException('Error al establecer el acceso al invernadero');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> setFrecuenciaTest(int semanaFrecuenciaTest, int frecuenciaTest) async {
    try {
      final Map<String, String> requestData = {
        'semanaFrecuenciaTest': semanaFrecuenciaTest.toString(),
        'frecuenciaTest': frecuenciaTest.toString(),
      };
      final response = await client.post(
        '$apiUrl/api/user/SetFrecuenciaTest',
        body: requestData,
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        throw ServerException('Error al establecer la frecuencia del test');
      }
    } catch (e) {
      rethrow;
    }
  }
}
