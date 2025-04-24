import '../../models/page_greenhouse.dart';
import '../../models/pensamiento.dart';

abstract class GreenhouseRepository {
  Future<bool> getShowMessageGreenhouse();
  Future<void> setShowMessageGreenhouse();
  Future<void> addPensamiento(Pensamiento pensamiento);
  Future<List<Pensamiento>?> getPensamientos(String? email);
  Future<bool> meGusta(String? emailEmisor, DateTime fechaPensamiento);
  Future<PageGreenhouse> getUsers(int page);
}
