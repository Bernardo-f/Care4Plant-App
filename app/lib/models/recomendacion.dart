// ignore_for_file: non_constant_identifier_names

import 'package:care4plant/models/categoria.dart';

class Recomendacion {
  final bool recom_realizada;
  final Categoria categoria;

  Recomendacion({required this.categoria, required this.recom_realizada});

  factory Recomendacion.fromJson(Map<String, dynamic> json) {
    return Recomendacion(
      recom_realizada: json['recom_realizada'],
      categoria: Categoria.fromJson(json['categoria']),
    );
  }
}
