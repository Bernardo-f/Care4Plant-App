import 'package:care4plant/domain/repositories/greenhouse_repository.dart';

import '../../models/pensamiento.dart';

class GetPensamientosUseCase {
  final GreenhouseRepository repository;

  GetPensamientosUseCase(this.repository);

  Future<List<Pensamiento>?> call(String? email) async {
    return await repository.getPensamientos(email);
  }
}
