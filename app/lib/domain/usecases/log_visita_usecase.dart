import '../../models/visita.dart';
import '../repositories/visita_repository.dart';

class LogVisitaUseCase {
  final VisitaRepository _visitaRepository;

  LogVisitaUseCase(this._visitaRepository);

  Future<void> call(Visita visita) async {
    await _visitaRepository.addVisita(visita);
  }
}
