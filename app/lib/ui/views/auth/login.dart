import 'dart:async';

import 'package:care4plant/ui/views/onboarding/welcome_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/services/l10n/l10n_service.dart';
import '../../../injection_container.dart';
import '../../../models/user_login.dart';

import '../../provider/get_plant_provider.dart';
import '../stressleveltest/stress_level_test.dart';
import '../../provider/login_provider.dart';
import '../components/alert_dialogs.dart';
import '../components/auth/auth_background.dart';
import '../components/auth/auth_bottom_bar.dart';
import '../components/auth/auth_input.dart';
import '../components/auth/auth_logo.dart';
import '../components/auth/auth_top_bar.dart';
import '../helpers/layout_helpers.dart';
import '../theme/app_colors.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  UserLogin userLogin = UserLogin(
      email: '', password: ''); //Se inicializa el modelo de userLogin con sus campos vacíos
  bool _firstRender =
      true; // Flag para indicar si es la primera vez que se renderiza, esto es para evitar que los mensajes de error de los campos se muestran al iniciar la pantalla

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, provider, child) {
      return Container(
        color: Colors.white,
        child: Stack(children: [
          background(), // imagen de fondo
          Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                  child: SizedBox(
                width: double.infinity,
                height: heightPercentage(1, context),
                child: Stack(
                  children: [
                    Align(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: inputBgDecoration(),
                        height: heightPercentage(.8, context),
                        width: double.infinity,
                        child: SizedBox(
                          width: widthPercentage(.8, context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 10, bottom: 30),
                                child: Text(
                                  L10nService.localizations.logIn,
                                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                              ),
                              input(L10nService.localizations.email, userLogin.setEmail,
                                  errorText:
                                      !(_firstRender) ? userLogin.validateEmail(context) : null),
                              input(L10nService.localizations.password, userLogin.setPassword,
                                  errorText:
                                      !(_firstRender) ? userLogin.validatePassword(context) : null,
                                  obscureText: true),
                            ],
                          ),
                        ),
                      ),
                    ),
                    topBar(context),
                  ],
                ),
              )),
              bottomNavigationBar: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  (provider.state == LoginState.idle)
                      ? InkWell(
                          onTap: () {
                            if (userLogin.validate()) {
                              _logIn();
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
                  bottomBar(L10nService.localizations.notAccount, L10nService.localizations.signUp,
                      context, "signup")
                ],
              ))
        ]),
      );
    });
  }

  Future<void> _logIn() async {
    try {
      final loginProvider = Provider.of<LoginProvider>(context, listen: false);
      await Provider.of<LoginProvider>(context, listen: false)
          .login(userLogin.email, userLogin.password);

      if (!mounted) return; // Verifica si el widget está montado antes de continuar

      switch (loginProvider.state) {
        case LoginState.loaded:
          return _redirectHome();
        case LoginState.error:
          showDialog(
            context: context,
            builder: (BuildContext context) => alertDialog(
                loginProvider.errorMessage != null
                    ? loginProvider.errorMessage as String
                    : "Ocurrio un error",
                context),
          );
          loginProvider.resetState();
          break;
        case LoginState.redirectStressTest:
          // Aquí puedes redirigir a la pantalla de la prueba de estrés
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                        create: (_) => GetPlantProvider(getPlantUseCase: sl()),
                        child: WelcomeMessageView(
                          message: L10nService.localizations.firstTestMessage,
                          nextPageBuilder: () => const StressLevelTest(redirect: true),
                        ),
                      )),
              (Route<dynamic> route) => false);
          break;
        case LoginState.idle:
          break;
        case LoginState.loading:
          break;
        case LoginState.redirectOnboarding:
          _redirectOnboarding();
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) => alertDialog(e.toString(), context),
      );
    } finally {}
  }

  void _redirectOnboarding() {
    Navigator.popAndPushNamed(context, 'onboarding');
  }

  void _redirectHome() {
    Navigator.popAndPushNamed(context, 'home');
  }
}
