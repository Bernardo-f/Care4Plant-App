// ignore_for_file: non_constant_identifier_names

class Actividad {
  final int id_actividad;
  final String nombre_actividad;
  final String imagen_actividad;
  final String descripcion_actividad;
  final String contenido_actividad;
  final Duration tiempo_actividad;

  Actividad(
      {required this.id_actividad,
      required this.nombre_actividad,
      required this.imagen_actividad,
      required this.descripcion_actividad,
      required this.contenido_actividad,
      required this.tiempo_actividad});

  factory Actividad.fromJson(Map<String, dynamic> json) {
    Duration parseDuration(String timeString) {
      List<String> parts = timeString.split(':');
      int hours = int.parse(parts[0]);
      int minutes = int.parse(parts[1]);
      int seconds = int.parse(parts[2]);

      return Duration(hours: hours, minutes: minutes, seconds: seconds);
    }

    return Actividad(
      id_actividad: json['id_actividad'] as int,
      nombre_actividad: json['nombre_actividad'].toString(),
      imagen_actividad: json['imagen_actividad'].toString(),
      descripcion_actividad: json['descripcion_actividad'].toString(),
      contenido_actividad: json['contenido_actividad'].toString(),
      tiempo_actividad: parseDuration(json['tiempo_actividad'].toString()),
    );
  }
}
