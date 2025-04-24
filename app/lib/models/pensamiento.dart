// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Pensamiento {
  final DateTime fecha_pensamiento;
  final String contenido_pensamiento;
  final int? numero_me_gustas;
  final bool? megusta;
  Pensamiento(
      {required this.contenido_pensamiento,
      required this.fecha_pensamiento,
      this.numero_me_gustas,
      this.megusta});

  Map<String, dynamic> toMap() {
    return {
      'fecha_pensamiento': fecha_pensamiento.toUtc().toIso8601String(),
      'contenido_pensamiento': contenido_pensamiento,
    };
  }

  //Funcion para pasar el objeto JSON usando toMap
  String toJson() => jsonEncode(toMap());

  factory Pensamiento.fromJson(Map<String, dynamic> json) {
    return Pensamiento(
        fecha_pensamiento: DateTime.parse(json['fecha_pensamiento'].toString()).toLocal(),
        contenido_pensamiento: json['contenido_pensamiento'].toString(),
        numero_me_gustas: json['numero_me_gustas'] as int,
        megusta: json['megusta']);
  }
}
