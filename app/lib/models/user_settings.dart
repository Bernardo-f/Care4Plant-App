// ignore_for_file: non_constant_identifier_names, avoid_init_to_null

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserSetting {
  late int? PlantId = null;
  late int frecuenciaTest = 0;
  late int semanaFrecuenciaTest = 0;
  late bool? notificacionTest = null;
  late bool? notificacionActividades = null;
  late bool? accesoInvernadero = null;
  late String idioma;

  UserSetting();

  //Se pasa el modelo a diccionario para poder transformalo a JSON
  Map<String, dynamic> toMap() {
    return {
      'PlantId': PlantId,
      'frecuencia_test': frecuenciaTest,
      'semana_frecuencia_test': semanaFrecuenciaTest,
      'notificacion_test': notificacionTest,
      'notificacion_actividades': notificacionActividades,
      'acceso_invernadero': accesoInvernadero,
      'idioma': idioma
    };
  }

  //Funcion para validar que el usuario haya ingresado todas las configuraciones
  bool validate() {
    if (PlantId == null ||
        accesoInvernadero == null ||
        notificacionActividades == null ||
        notificacionTest == null ||
        frecuenciaTest == 0 ||
        semanaFrecuenciaTest == 0) {
      return false;
    }
    return true;
  }

  //Funcion para pasar el objeto JSON usando toMap
  String toJson() => jsonEncode(toMap());
  // getters y setters
  get getIdPlanta => PlantId;

  set setIdPlanta(PlantId) => this.PlantId = PlantId;

  get getFrecuenciaTest => frecuenciaTest;

  set setFrecuenciaTest(frecuenciaTest) => this.frecuenciaTest = frecuenciaTest;

  get getSemanaFrecuenciaTest => semanaFrecuenciaTest;

  set setSemanaFrecuenciaTest(semanaFrecuenciaTest) =>
      this.semanaFrecuenciaTest = semanaFrecuenciaTest;

  get getNotificacionTest => notificacionTest;

  set setNotificacionTest(notificacionTest) => this.notificacionTest = notificacionTest;

  get getNotificacionActividades => notificacionActividades;

  set setNotificacionActividades(notificacionActividades) =>
      this.notificacionActividades = notificacionActividades;

  get getAccesoInvernadero => accesoInvernadero;

  set setAccesoInvernadero(accesoInvernadero) => this.accesoInvernadero = accesoInvernadero;

  get getIdioma => idioma;

  set setIdioma(idioma) => this.idioma = idioma;

  void saveSetting() async {
    //Guarda los ajustes en la memoria local del dispositivo
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (validate()) {
      prefs.setInt('frecuenciaTest', frecuenciaTest);
      prefs.setInt('semanaFrecuenciaTest', semanaFrecuenciaTest);
      prefs.setBool('notificacionTest', notificacionTest!);
      prefs.setBool('notificacionActividades', notificacionActividades!);
      prefs.setBool('accesoInvernadero', accesoInvernadero!);
    }
  }
}
