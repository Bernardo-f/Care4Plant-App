import 'package:care4plant/models/actividad.dart';

import '../../domain/repositories/actividad_repository.dart';
import '../source/remote/actividad_remote_data_source.dart';

class ActividadRepositoryImpl extends ActividadRepository {
  final ActividadRemoteDataSource _actividadRemoteDataSource;

  ActividadRepositoryImpl(this._actividadRemoteDataSource);

  @override
  Future<List<Actividad>> getAllByCategoria(int idCategoria) async {
    try {
      final result = await _actividadRemoteDataSource.getAllByCategoria(idCategoria);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> addIngresoActividad(int idActividad, bool finalizada) async {
    try {
      final result = await _actividadRemoteDataSource.addIngresoActividad(idActividad, finalizada);
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
