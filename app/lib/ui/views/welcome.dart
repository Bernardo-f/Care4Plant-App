import 'package:flutter/material.dart';
//Se importan los componentes compartidos

import 'package:provider/provider.dart';

import '../../core/services/l10n/l10n_service.dart';
import '../../injection_container.dart';
import '../../ui/provider/login_provider.dart';
import '../provider/signup_provider.dart';
import 'components/auth/auth_background.dart';
import 'components/auth/auth_logo.dart';
import 'components/filled_button.dart';
import 'helpers/layout_helpers.dart';
import 'auth/login.dart';
import 'auth/signup.dart';
import 'theme/app_colors.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(children: [
        background(), // Retorna el fondo de esta pantalla
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: widthPercentage(
                    .8, context), // Se crea una contenedor con un ancho del 80% segun la pantalla
                child: Align(
                  alignment: Alignment.centerLeft, // Se alinea a la izquierda centrado
                  child:
                      logo(200.0), // Logo de la aplicación, recibe como parametro el ancho del logo
                ),
              ),
              const Text(
                "Care4Plant", // Texto principal que se muestra al abrir la apliación
                style: TextStyle(
                    color: primaryColor,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40.0),
                width: widthPercentage(
                    .8, context), // Se crea un contenedor con un ancho del 80% según la pantalla
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    filledButton(
                        L10nService.localizations.logIn, //Texto
                        Colors.white, // Color del texto
                        primaryColor, // Paddinf horizontal del botón
                        30.0, // Padding horizontal del botón
                        context, // Build context para redireccionar
                        ChangeNotifierProvider(
                            create: (_) => LoginProvider(loginUseCase: sl()),
                            child: const LoginView()), // Componente al que se redirecciona
                        null), // Color del borde (Si es nulo no tiene borde)
                    filledButton(
                        L10nService.localizations.signUp, //Texto
                        primaryColor, // Color del Texto
                        Colors.transparent, // Color de fondo del botón
                        30.0, // Padding horizontal del botón
                        context, // Build context para redireccionar
                        ChangeNotifierProvider(
                          create: (_) => SignUpProvider(signUpUseCase: sl()),
                          child: const SignUpView(),
                        ), // Componente al que se redirecciona
                        primaryColor) // Color del borde
                  ],
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
