import '../../models/visita.dart';

abstract class VisitaRepository {
  // This class will handle
  Future<void> addVisita(Visita visita);
}
