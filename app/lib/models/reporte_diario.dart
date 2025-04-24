// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ReporteDiario {
  final DateTime fecha_reporte;
  final int estado_reporte;

  ReporteDiario({required this.estado_reporte, DateTime? fecha_reporte})
      : fecha_reporte = fecha_reporte ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'fecha_reporte': fecha_reporte.toUtc().toIso8601String(),
      'estado_reporte': estado_reporte,
    };
  }

  factory ReporteDiario.fromJson(Map<String, dynamic> json) {
    return ReporteDiario(
      estado_reporte: json['estado_reporte'] as int,
      fecha_reporte: DateTime.parse(json['fecha_reporte'].toString()),
    );
  }
  //Funcion para pasar el objeto JSON usando toMap
  String toJson() => jsonEncode(toMap());

  //Funcion para guardar el reporte en la memoria del dispositivo
  void saveReporte() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        'fecha_reporte',
        fecha_reporte
            .toIso8601String()); // se almacena localmente la fecha del ultimo estado diario
    prefs.setInt('estado_reporte', estado_reporte);
  }
}
