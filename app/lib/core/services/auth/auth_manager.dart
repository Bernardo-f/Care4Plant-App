import 'package:care4plant/injection_container.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../ui/provider/get_plant_provider.dart';
import '../../../ui/provider/register_stress_test_provider.dart';
import '../../../ui/provider/validate_session_provider.dart';
import '../../../ui/views/Home/home.dart';
import '../../../ui/views/components/wave_loader.dart';
import '../../../ui/views/onboarding/onboarding.dart';
import '../../../ui/views/onboarding/welcome_message.dart';
import '../../../ui/views/welcome.dart';
import '../../../ui/views/stressleveltest/stress_level_test.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../network/custom_http_client.dart';
import '../l10n/l10n_service.dart';

class AuthManager extends StatefulWidget {
  const AuthManager({Key? key}) : super(key: key);

  @override
  AuthManagerState createState() => AuthManagerState();
}

class AuthManagerState extends State<AuthManager> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ValidateSessionProvider>(context, listen: false).validateSession();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final localeName = AppLocalizations.of(context)!.localeName;
    // Al iniciar la aplicación, se establece el idioma en el cliente HTTP
    // para que todas las peticiones se realicen en el idioma seleccionado por el usuario.
    sl<CustomHttpClient>().setLocale(localeName);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ValidateSessionProvider>(
      builder: (context, provider, child) {
        L10nService.init(context); // Inicializa el servicio de traducción
        return _buildContext(provider.state);
      },
    );
  }

  Widget _buildContext(ValidateSessionState state) {
    L10nService.init(context); // Inicializa el servicio de traducción
    sl<CustomHttpClient>()
        .setLocale(L10nService.localizations.localeName); // Establece el idioma en el cliente HTTP
    switch (state) {
      case ValidateSessionState.idle:
        return const LoadingScreen();
      case ValidateSessionState.loading:
        return const LoadingScreen();
      case ValidateSessionState.home:
        return const HomeView();
      case ValidateSessionState.login:
        return const OnboardingView();
      case ValidateSessionState.stressLevelTest:
        return ChangeNotifierProvider(
            create: (_) => GetPlantProvider(getPlantUseCase: sl()),
            child: WelcomeMessageView(
                message: AppLocalizations.of(context)!.firstTestMessage,
                nextPageBuilder: () => ChangeNotifierProvider(
                    create: (_) => RegisterStressTestProvider(registerStressTestUseCase: sl()),
                    child: const StressLevelTest(
                      redirect: true,
                    ))));
      case ValidateSessionState.error:
        return const WelcomeView();
      default:
        return const LoadingScreen();
    }
  }
}
