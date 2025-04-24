import 'package:care4plant/domain/repositories/user_repository.dart';

import '../../models/recomendacion.dart';

class GetCategoriasRecomendadasUseCase {
  final UserRepository repository;

  GetCategoriasRecomendadasUseCase(this.repository);

  Future<List<Recomendacion>> call() async {
    return await repository.getCategoriasRecomendadas();
  }
}
