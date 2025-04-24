import 'package:care4plant/models/recomendacion.dart';

import '../../models/accesorio.dart';
import '../../models/plant.dart';
import '../../models/user_settings.dart';

abstract class UserRepository {
  Future<String> getName();
  Future<int> getStressLevel();
  Future<int?> getReporteDiario();
  Future<List<Accesorio>?> getAccesorios();
  Future<String?> getPlantByStressLevel();
  Future<List<Recomendacion>> getCategoriasRecomendadas();
  Future<int?> getSemanaFrecuenciaTest();
  Future<int?> getFrecuenciaTest();
  Future<bool?> getAccesoInvernadero();
  Future<bool?> getNotificacionTest();
  Future<bool?> getNotificacionActividades();

  Future<int> usarAccesorio(int idAccesorio);
  Future<Plant> saveSettings(UserSetting userSetting);
  Future<bool> setStressLevel(int stressLevel);
  Future<bool> validateDateTest();
  Future<void> logout();

  Future<void> setNotificacionTest(bool value);
  Future<void> setNotificacionActividades(bool value);
  Future<void> setAccesoInvernadero(bool value);
  Future<bool> setFrecuenciaTest(int semanaFrecuenciaTest, int frecuenciaTest);
}
