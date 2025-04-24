import 'package:care4plant/ui/provider/get_name_provider.dart';
import 'package:care4plant/ui/views/Home/home.dart';
import 'package:flutter/material.dart';

//Libreria encargada de las traducciones
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'core/services/auth/auth_manager.dart';
import 'injection_container.dart';
import 'ui/provider/login_provider.dart';
import 'ui/provider/signup_provider.dart';
import 'ui/provider/validate_session_provider.dart';
import 'ui/views/auth/login.dart';
import 'ui/views/auth/signup.dart';
import 'ui/views/components/wave_loader.dart';
import 'ui/views/onboarding/onboarding.dart';
import 'ui/views/theme/app_colors.dart';
import 'ui/views/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => GetNameProvider(getNameUseCase: sl())..init(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        fontFamily: 'Segoe UI', // Para setear la fuente por defecto de la aplicación
        dividerColor: Colors.transparent,
        appBarTheme:
            const AppBarTheme(shadowColor: Colors.transparent, backgroundColor: Colors.transparent),
        scrollbarTheme: const ScrollbarThemeData(
            thumbColor: MaterialStatePropertyAll(primaryColor),
            radius: Radius.circular(50)), // estilo de la scrollbar
      ),
      title: 'Care4plant',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      //Idiomas soportados por la aplicación
      supportedLocales: const [Locale('es'), Locale('en'), Locale('cy')], //,
      localeResolutionCallback: (locale, supportedLocales) {
        // Usa el idioma del sistema si está disponible, de lo contrario, selecciona un idioma predeterminado.
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first; // Predeterminado (en este caso, inglés)
      },
      home: ChangeNotifierProvider(
        create: (_) => ValidateSessionProvider(validateSessionUseCase: sl()),
        child: const AuthManager(),
      ),
      routes: {
        "login": (context) => ChangeNotifierProvider(
            create: (_) => LoginProvider(loginUseCase: sl()), child: const LoginView()),
        "signup": (context) => ChangeNotifierProvider(
            create: (_) => SignUpProvider(signUpUseCase: sl()), child: const SignUpView()),
        "onboarding": (context) => const OnboardingView(),
        "loadingScreen": (context) => const LoadingScreen(),
        "home": (context) => const HomeView(),
        "welcome": (context) => const WelcomeView()
      },
    );
  }
}
