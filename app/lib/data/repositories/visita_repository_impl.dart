import '../../domain/repositories/visita_repository.dart';
import '../../models/visita.dart';
import '../source/remote/visita_remote_data_source.dart';

class VisitaRepositoryImpl extends VisitaRepository {
  // This class will handle
  final VisitaRemoteDataSource _visitaRemoteDataSource;

  VisitaRepositoryImpl(this._visitaRemoteDataSource);

  @override
  Future<void> addVisita(Visita visita) async {
    try {
      await _visitaRemoteDataSource.addVisita(visita);
    } catch (e) {
      rethrow;
    }
  }
}
