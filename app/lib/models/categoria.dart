// ignore_for_file: non_constant_identifier_names

class Categoria {
  final int id_categoria;
  final String nombre_categoria;
  final String descripcion_categoria;
  final String imagen_categoria;
  final String icono_categoria;
  final int layout_categoria;

  Categoria(
      {required this.id_categoria,
      required this.nombre_categoria,
      required this.descripcion_categoria,
      required this.imagen_categoria,
      required this.icono_categoria,
      required this.layout_categoria});

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id_categoria: json['id_categoria'] as int,
      nombre_categoria: json['nombre_categoria'].toString(),
      descripcion_categoria: json['descripcion_categoria'].toString(),
      imagen_categoria: json['imagen_categoria'].toString(),
      icono_categoria: json['icono_categoria'].toString(),
      layout_categoria: json['layout_categoria'] as int,
    );
  }
}
