import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  String nombre;
  bool firstLogin;
  int? frecuenciaTest;
  int? semanaFrecuenciaTest;
  bool? notificacionTest;
  int? nivelEstres;
  bool? notificacionActividades;
  bool? accesoInvernadero;

  UserInfo(
      {required this.nombre,
      required this.firstLogin,
      required this.frecuenciaTest,
      required this.semanaFrecuenciaTest,
      required this.nivelEstres,
      required this.notificacionTest,
      required this.notificacionActividades,
      required this.accesoInvernadero});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      nombre: json['nombre'],
      firstLogin: json['first_login'],
      nivelEstres: json['nivel_estres'],
      frecuenciaTest: json['frecuencia_test'],
      semanaFrecuenciaTest: json['semana_frecuencia_test'],
      notificacionTest: json['notificacion_test'],
      notificacionActividades: json['notificacion_actividades'],
      accesoInvernadero: json['acceso_invernadero'],
    );
  }

  Future<void> saveInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nombre', nombre);
    prefs.setBool('first_login', firstLogin);
    if (frecuenciaTest != null) {
      prefs.setInt('frecuenciaTest', frecuenciaTest!);
    }
    if (semanaFrecuenciaTest != null) {
      prefs.setInt('semanaFrecuenciaTest', semanaFrecuenciaTest!);
    }
    if (notificacionTest != null) {
      prefs.setBool('notificacionTest', notificacionTest!);
    }
    if (nivelEstres != null) {
      prefs.setInt('nivelEstres', nivelEstres!);
    }
    if (notificacionActividades != null) {
      prefs.setBool('notificacionActividades', notificacionActividades!);
    }
    if (accesoInvernadero != null) {
      prefs.setBool('accesoInvernadero', accesoInvernadero!);
    }
  }
}
