import 'dart:convert';

import 'package:care4plant/models/actividad.dart';

import '../../../core/services/network/custom_http_client.dart';
import '../../../env.dart';
import '../../../models/ingresa.dart';

class ActividadRemoteDataSource {
  final CustomHttpClient client;

  ActividadRemoteDataSource(this.client);

  Future<List<Actividad>> getAllByCategoria(int idCategoria) {
    try {
      final response = client.get(
        '$apiUrl/api/Actividad/GetByCategoria?id_categoria=$idCategoria',
      );
      final parsed = response.then((res) {
        if (res.statusCode == 200) {
          final parsed = jsonDecode(res.body).cast<Map<String, dynamic>>();
          List<Actividad> actividades =
              parsed.map<Actividad>((json) => Actividad.fromJson(json)).toList();
          return actividades;
        } else {
          throw Exception('Failed to load actividades');
        }
      });
      return parsed;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> addIngresoActividad(int idActividad, bool finalizada) async {
    try {
      Ingresa ingresa = Ingresa(
        id_actividad: idActividad, // Replace with actual id_actividad
        fecha_ingreso: DateTime.now(),
        finalizada: finalizada,
      );
      final response =
          await client.post('$apiUrl/api/visita/addIngresoActividad', body: ingresa.toMap());
      if (response.statusCode != 200) {
        throw Exception('Failed to add ingreso actividad');
      } else {
        return response.body;
      }
    } catch (e) {
      rethrow;
    }
  }
  //   Future<http.Response> saveIngresa(bool finalizada) async {
  //   Ingresa ingresa = Ingresa(
  //       id_actividad: widget.actividad.id_actividad,
  //       fecha_ingreso: fechaingreso,
  //       finalizada: finalizada);
  //   String? token = await AuthService().getToken();
  //   var headers = {
  //     'Accept-Language': widget.acceptLanguage,
  //     'Authorization': 'Bearer $token',
  //     'Content-Type': 'application/json'
  //   };
  //   final response = await http.post(Uri.parse("$apiUrl/api/visita/addIngresoActividad"),
  //       headers: headers, body: ingresa.toJson());
  //   return response;
  // }
}
