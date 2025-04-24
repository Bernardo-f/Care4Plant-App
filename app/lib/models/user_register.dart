// ignore: file_names
import 'dart:convert';
// traducción
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserRegister {
  String email; //Email para registrarse
  String nombre; //Nombre para registrarse
  String password; // contraseña para registrarse
  String repeatPassword; // validacion de la contraseña

  UserRegister(
      {required this.email,
      required this.nombre,
      required this.password,
      required this.repeatPassword}); //constructor

  //Se pasa el modelo a diccionario para poder transformalo a JSON no se agrega repeat password ya que no se envia dos veces a la api
  Map<String, String> toMap() {
    return {
      'email': email,
      'nombre': nombre,
      'password': password,
    };
  }

  void setEmail(String email) => this.email = email;

  void setNombre(String nombre) => this.nombre = nombre;

  void setPassword(String password) => this.password = password;

  void setRepeatPassword(String repeatPassword) => this.repeatPassword = repeatPassword;

  String? validateName(BuildContext context) {
    if (nombre == '') {
      return AppLocalizations.of(context)!.requiredField;
    }
    if (nombre.length > 50) {
      return AppLocalizations.of(context)!.nameLength;
    }
    return null;
  }

  String? validateEmail(BuildContext context) {
    if (email == '') {
      return AppLocalizations.of(context)!.requiredField;
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return AppLocalizations.of(context)!.emailFormat;
    }
    return null;
  }

  String? validatePassword(BuildContext context) {
    if (password == '') {
      return AppLocalizations.of(context)!.requiredField;
    }
    if (password.length < 8) {
      return AppLocalizations.of(context)!.passwordLength;
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$').hasMatch(password)) {
      return AppLocalizations.of(context)!.passwordCharacters;
    }
    return null;
  }

  String? validateRepeatPassword(BuildContext context) =>
      (repeatPassword != password) ? AppLocalizations.of(context)!.passwordMatch : null;

  bool validate() {
    if ((nombre != '') && (email != '') && (password != '') && (repeatPassword == password)) {
      return true;
    }
    return false;
  }

  // Función para pasar de Json a la clase
  factory UserRegister.fromMap(Map<String, dynamic> map) {
    return UserRegister(
        email: map['email'],
        nombre: map['name'],
        password: map['password'],
        repeatPassword: map['repeatPassword']);
  }

  //Funcion para pasar el objeto JSON usando toMap
  String toJson() => jsonEncode(toMap());

  //Funcion para pasar de JSON a el objecto de tipo UserLogin
  factory UserRegister.fromJson(String source) => UserRegister.fromMap(json.decode(source));
}
