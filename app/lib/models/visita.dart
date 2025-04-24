// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Visita {
  final int id_categoria;
  final DateTime fecha_visita;
  final Duration tiempo_visita;

  Visita({required this.id_categoria, required this.fecha_visita, required this.tiempo_visita});

  Map<String, dynamic> toMap() {
    return {
      'id_categoria': id_categoria,
      'fecha_visita': fecha_visita.toUtc().toIso8601String(),
      'tiempo_visita': tiempo_visita.toString(),
    };
  }

  //Funcion para pasar el objeto JSON usando toMap
  String toJson() => jsonEncode(toMap());
}
