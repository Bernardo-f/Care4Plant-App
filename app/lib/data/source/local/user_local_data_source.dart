import 'package:care4plant/models/plant.dart';
import 'package:care4plant/models/user_info.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/user_settings.dart';
import '../../../core/services/notifications/notifications_service.dart';

class UserLocalDataSource {
  late SharedPreferences sharedPreferences;

  Future<void> saveInfo(UserInfo userInfo) async {
    sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString('nombre', userInfo.nombre);
    sharedPreferences.setBool('first_login', userInfo.firstLogin);
    if (userInfo.frecuenciaTest != null) {
      sharedPreferences.setInt('frecuenciaTest', userInfo.frecuenciaTest!);
    }
    if (userInfo.semanaFrecuenciaTest != null) {
      sharedPreferences.setInt('semanaFrecuenciaTest', userInfo.semanaFrecuenciaTest!);
    }
    if (userInfo.notificacionTest != null) {
      sharedPreferences.setBool('notificacionTest', userInfo.notificacionTest!);
    }
    if (userInfo.nivelEstres != null) {
      sharedPreferences.setInt('nivelEstres', userInfo.nivelEstres!);
    }
    if (userInfo.notificacionActividades != null) {
      sharedPreferences.setBool('notificacionActividades', userInfo.notificacionActividades!);
    }
    if (userInfo.accesoInvernadero != null) {
      sharedPreferences.setBool('accesoInvernadero', userInfo.accesoInvernadero!);
    }
  }

  Future<void> savePlant(Plant plant) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList('myPlant', plant.getListImages());
  }

  Future<UserInfo> getInfo() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return UserInfo(
      nombre: sharedPreferences.getString('nombre')!,
      firstLogin: sharedPreferences.getBool('first_login')!,
      frecuenciaTest: sharedPreferences.getInt('frecuenciaTest'),
      semanaFrecuenciaTest: sharedPreferences.getInt('semanaFrecuenciaTest'),
      notificacionTest: sharedPreferences.getBool('notificacionTest'),
      nivelEstres: sharedPreferences.getInt('nivelEstres'),
      notificacionActividades: sharedPreferences.getBool('notificacionActividades'),
      accesoInvernadero: sharedPreferences.getBool('accesoInvernadero'),
    );
  }

  Future<void> saveSettings(UserSetting userSetting) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('frecuenciaTest', userSetting.frecuenciaTest);
    sharedPreferences.setInt('semanaFrecuenciaTest', userSetting.semanaFrecuenciaTest);
    sharedPreferences.setBool('notificacionTest', userSetting.notificacionTest!);
    sharedPreferences.setBool('notificacionActividades', userSetting.notificacionActividades!);
    sharedPreferences.setBool('accesoInvernadero', userSetting.accesoInvernadero!);
  }

  Future<void> saveStressLevel(int stressTest) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('nivelEstres', stressTest);
  }

  Future<int> getStressLevel() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt('nivelEstres')!;
  }

  /// Obtiene la planta del usuario desde SharedPreferences
  Future<String> getPlant() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList('myPlant')![1];
  }

  Future<String> getName() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('nombre')!;
  }

  Future<String?> getPlantByStressLevel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? myPlant = prefs.getStringList("myPlant");
    int? stressLevel = prefs.getInt("nivelEstres");
    if (stressLevel != null && myPlant != null) {
      if (stressLevel <= 5) return myPlant[0];
      if (stressLevel <= 10) return myPlant[1];
      if (stressLevel <= 15) return myPlant[2];
      if (stressLevel <= 20) return myPlant[3];
      return myPlant[4];
    }
    return null;
  }

  Future<int?> getReporteDiario() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('fecha_reporte') != null) {
      final dateTime = DateTime.parse(prefs.getString('fecha_reporte')!);
      // Si ha pasado mas de un dia se retorna nulo y significa que el cuidador puede ingresar un nuevo estado diario
      if (DateTime.now().difference(dateTime).inDays >= 1) {
        return null;
      }
    }
    return prefs.getInt("estado_reporte");
  }

  Future<int?> getSemanaFrecuenciaTest() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("semanaFrecuenciaTest");
  }

  Future<int?> getFrecuenciaTest() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("frecuenciaTest");
  }

  Future<bool> setFrecuenciaTest(int semanaFrecuenciaTest, int frecuenciaTest) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('semanaFrecuenciaTest', semanaFrecuenciaTest);
    prefs.setInt('frecuenciaTest', frecuenciaTest);
    return true;
  }

  Future<bool?> getAccesoInvernadero() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("accesoInvernadero");
  }

  Future<bool> setAccesoInvernadero(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("accesoInvernadero", value);
  }

  Future<bool?> getNotificacionTest() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("notificacionTest");
  }

  Future<bool> setNotificacionTest(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("notificacionTest", value);
  }

  Future<bool?> getNotificacionActividades() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("notificacionActividades");
  }

  Future<bool> setNotificacionActividades(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("notificacionActividades", value);
  }

  Future<void> logout() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    storage.deleteAll();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await NotificationsService().clearNotifications();
    prefs.clear();
  }
}
