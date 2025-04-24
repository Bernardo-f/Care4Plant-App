import '../../models/pensamiento.dart';
import '../repositories/greenhouse_repository.dart';

class AddPensamientoUseCase {
  final GreenhouseRepository _repository;

  AddPensamientoUseCase(this._repository);

  Future<void> call(Pensamiento pensamiento) async {
    await _repository.addPensamiento(pensamiento);
  }
}
