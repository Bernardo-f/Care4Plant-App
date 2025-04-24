import 'dart:async';
import 'package:flutter/material.dart';
//Peticiones http
import 'package:provider/provider.dart';

import '../../../core/services/l10n/l10n_service.dart';
import '../../../models/user_register.dart';

import '../../provider/signup_provider.dart';
import '../components/alert_dialogs.dart';
import '../components/auth/auth_background.dart';
import '../components/auth/auth_bottom_bar.dart';
import '../components/auth/auth_input.dart';
import '../components/auth/auth_logo.dart';
import '../components/auth/auth_top_bar.dart';
import '../helpers/layout_helpers.dart';
import '../theme/app_colors.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);
  @override
  SignUpViewState createState() => SignUpViewState();
}

class SignUpViewState extends State<SignUpView> {
  UserRegister userRegister = UserRegister(
      email: '',
      nombre: '',
      password: '',
      repeatPassword: ''); // Se inicializa el modelo userRegister con sus campos vacíos
  bool _firstRender =
      true; // Flag para indicar si es la primera vez que se renderiza, esto es para evitar que los mensajes de error de los campos se muestran al iniciar la pantalla

  @override
  void dispose() {
    //Libera los recursos al eliminar el componente
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(builder: (context, provider, child) {
      return Container(
        color: Colors.white,
        child: Stack(children: [
          background(), // Retorna el fondo de esta pantalla
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                height: heightPercentage(1, context),
                child: Stack(children: [
                  Align(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: inputBgDecoration(),
                      child: SizedBox(
                        width: widthPercentage(.8, context),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 10, bottom: 30),
                                child: Text(
                                  L10nService.localizations.signUp,
                                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                              ),
                              input(L10nService.localizations.name, userRegister.setNombre,
                                  errorText: !(_firstRender)
                                      ? userRegister.validateName(context)
                                      : null), // Input donde se ingresa el nombre
                              input(L10nService.localizations.email, userRegister.setEmail,
                                  errorText: !(_firstRender)
                                      ? userRegister.validateEmail(context)
                                      : null), // Input donde se ingresa el correo
                              input(L10nService.localizations.password,
                                  userRegister.setPassword, // Input donde se ingresa la contraseña
                                  obscureText: true,
                                  errorText: !(_firstRender)
                                      ? userRegister.validatePassword(context)
                                      : null),
                              input(L10nService.localizations.repeatPassword,
                                  userRegister.setRepeatPassword,
                                  obscureText: true,
                                  errorText: !(_firstRender)
                                      ? userRegister.validateRepeatPassword(context)
                                      : null), // Input donde se reingresa la contraseña
                            ]),
                      ),
                    ),
                  ),
                  topBar(context), // Barra superior que contiene el logo y nombre de la app
                ]),
              ),
            ),
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                (provider.state == SignUpState.idle)
                    ? InkWell(
                        onTap: () {
                          if (userRegister.validate()) {
                            _signup();
                          } else {
                            setState(() {
                              _firstRender = false;
                            });
                          }
                        },
                        child: iconArrow(),
                      )
                    : const CircularProgressIndicator(
                        color: primaryColor,
                      ),
                bottomBar(L10nService.localizations.alreadyAccount, L10nService.localizations.logIn,
                    context, "login")
              ],
            ),
          )
        ]),
      );
    });
  }

  Future<void> _signup() async {
    final signupProvider = Provider.of<SignUpProvider>(context, listen: false);
    await Provider.of<SignUpProvider>(context, listen: false).signUp(userRegister);

    if (!mounted) return; // Verifica si el widget está montado antes de continuar

    switch (signupProvider.state) {
      case SignUpState.loaded:
        await showDialog(
          context: context,
          builder: (BuildContext context) => alertDialog(
              signupProvider.errorMessage != null
                  ? signupProvider.errorMessage as String
                  : "Ocurrio un error",
              context),
        );
        _redirectLogin();
        break;
      case SignUpState.error:
        showDialog(
          context: context,
          builder: (BuildContext context) => alertDialog(
              signupProvider.errorMessage != null
                  ? signupProvider.errorMessage as String
                  : "Ocurrio un error",
              context),
        );
        signupProvider.resetState();
        break;
      case SignUpState.idle:
        break;
      case SignUpState.loading:
        break;
    }
  }

  _redirectLogin() {
    Navigator.pushNamedAndRemoveUntil(context, "login", ModalRoute.withName('/'));
  }
}
