import 'package:care4plant/domain/repositories/actividad_repository.dart';

import '../../models/actividad.dart';

class GetActividadesByCategoriaUseCase {
  final ActividadRepository repository;

  GetActividadesByCategoriaUseCase(this.repository);

  Future<List<Actividad>> call(int idCategoria) async {
    return await repository.getAllByCategoria(idCategoria);
  }
}
