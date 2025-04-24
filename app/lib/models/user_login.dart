import 'dart:convert';
// traducción
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserLogin {
  String email; //Email para iniciar sesion
  String password; // contraseña para iniciar sesion

  UserLogin({required this.email, required this.password}); //constructor

  //Se pasa el modelo a diccionario para poder transformalo a JSON
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  //Setters
  void setEmail(String email) => this.email = email;

  void setPassword(String password) => this.password = password;

  //Validaciones por cada campo para desplegar mensajes de campos faltantes
  String? validateEmail(BuildContext context) =>
      (email == '') ? AppLocalizations.of(context)!.requiredField : null;

  String? validatePassword(BuildContext context) =>
      (password == '') ? AppLocalizations.of(context)!.requiredField : null;

  //Validacion previa de todo el modelo para enviar los datos
  bool validate() {
    if ((email != '') && (password != '')) {
      return true;
    }
    return false;
  }

  // Función para pasar de Json a la clase
  factory UserLogin.fromMap(Map<String, dynamic> map) {
    return UserLogin(email: map['email'], password: map['password']);
  }

  //Funcion para pasar el objeto JSON usando toMap
  String toJson() => jsonEncode(toMap());

  //Funcion para pasar de JSON a el objecto de tipo UserLogin
  factory UserLogin.fromJson(String source) => UserLogin.fromMap(json.decode(source));
}
