// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Ingresa {
  final int id_actividad;
  final DateTime fecha_ingreso;
  final bool finalizada;
  Ingresa({required this.id_actividad, required this.fecha_ingreso, required this.finalizada});

  //Se pasa el modelo a diccionario para poder transformalo a JSON
  Map<String, dynamic> toMap() {
    return {
      'id_actividad': id_actividad,
      'fecha_ingreso': fecha_ingreso.toUtc().toIso8601String(),
      'finalizada': finalizada,
    };
  }

  //Funcion para pasar el objeto JSON usando toMap
  String toJson() => jsonEncode(toMap());
}
