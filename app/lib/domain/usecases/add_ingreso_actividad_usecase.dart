import 'package:care4plant/domain/repositories/actividad_repository.dart';

import '../../core/services/notifications/notifications_service.dart';

class AddIngresoActividadUseCase {
  final ActividadRepository _repository;

  AddIngresoActividadUseCase(this._repository);

  Future<String> call(int idActividad, bool finalizada) async {
    try {
      final response = await _repository.addIngresoActividad(idActividad, finalizada);
      NotificationsService().saveActivitiesNotification();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
