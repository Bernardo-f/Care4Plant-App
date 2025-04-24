import 'package:care4plant/models/actividad.dart';

abstract class ActividadRepository {
  Future<List<Actividad>> getAllByCategoria(int idCategoria);
  Future<String> addIngresoActividad(int idActividad, bool finalizada);
}
