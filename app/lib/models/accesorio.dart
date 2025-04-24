// ignore_for_file: non_constant_identifier_names

class Accesorio {
  final int id_accesorio;
  final String accion_accesorio;
  final String imagen_accesorio;
  final int cantidad;

  Accesorio(
      {required this.id_accesorio,
      required this.accion_accesorio,
      required this.imagen_accesorio,
      required this.cantidad});

  factory Accesorio.fromJson(Map<String, dynamic> json) {
    return Accesorio(
      id_accesorio: json['id_accesorio'] as int,
      accion_accesorio: json['accion_accesorio'].toString(),
      imagen_accesorio: json['imagen_accesorio'].toString(),
      cantidad: json['cantidad'] as int,
    );
  }
}
