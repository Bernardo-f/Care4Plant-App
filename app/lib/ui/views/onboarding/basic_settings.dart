import 'package:care4plant/core/services/l10n/l10n_service.dart';

import 'package:care4plant/models/user_settings.dart';
import 'package:care4plant/ui/provider/register_stress_test_provider.dart';
import 'package:care4plant/ui/provider/save_settings_provider.dart';
import 'package:care4plant/ui/views/onboarding/welcome_message.dart';

import 'package:care4plant/ui/views/stressleveltest/stress_level_test.dart';
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../../../injection_container.dart';
import '../components/alert_dialogs.dart';
import '../components/wave_loader.dart';
import '../helpers/layout_helpers.dart';
import '../theme/app_colors.dart';
import 'components/greenhouse.dart';
import 'components/notifications.dart';
import 'components/page_settings.dart';
import 'components/select_plant.dart';
import 'components/stress_test.dart';

class BasicSettingsView extends StatefulWidget {
  const BasicSettingsView({Key? key}) : super(key: key);

  @override
  BasicSettingsViewState createState() => BasicSettingsViewState();
}

class BasicSettingsViewState extends State<BasicSettingsView> with AutomaticKeepAliveClientMixin {
  final storage = const FlutterSecureStorage();
  // Se inicializa userSetting, sin ninguna configuración agregada
  UserSetting userSetting = UserSetting();
  int currentPage = 0;
  final textColor = const Color.fromRGBO(58, 60, 62, 1);
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: currentPage, keepPage: true, viewportFraction: 1.0);
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.toInt();
      });
    });
  }

  void changePlant(int id) {
    setState(() {
      userSetting.PlantId = id;
    });
  }

  void changeStressTest(int frecuenciaTest, int semanaFrecuenciaTest) {
    setState(() {
      userSetting.setFrecuenciaTest = frecuenciaTest;
      userSetting.setSemanaFrecuenciaTest = semanaFrecuenciaTest;
    });
  }

  void changeNotificationTest(bool value) {
    setState(() {
      userSetting.notificacionTest = value;
    });
  }

  void changeNotificationActividades(bool value) {
    setState(() {
      userSetting.notificacionActividades = value;
    });
  }

  void changeAccesoInvernadero(bool value) {
    setState(() {
      userSetting.accesoInvernadero = value;
    });
  }

  void saveSettings() async {
    if (!userSetting.validate()) {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              alertDialog(L10nService.localizations.validateSettings, context));
      return;
    }
    userSetting.setIdioma = L10nService.localizations.localeName;

    final provider = Provider.of<SaveSettingsProvider>(context, listen: false);
    provider.saveSettings(userSetting);
  }

  // Muestra la pantalla de carga
  void showLoadingPage() => Navigator.pushNamed(context, "loadingScreen");

  @override
  bool get wantKeepAlive => true; // Mantiene el estado de este widget

  void nextPage() => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => WelcomeMessageView(
                message: L10nService.localizations.firstTestMessage,
                nextPageBuilder: () => ChangeNotifierProvider(
                  create: (_) => RegisterStressTestProvider(registerStressTestUseCase: sl()),
                  child: const StressLevelTest(redirect: true),
                ),
              )),
      (Route<dynamic> route) => false);

  Widget buildPage(int index, BuildContext context) {
    switch (index) {
      case 0:
        return pageSetting(
            L10nService.localizations.settingPlantTittle,
            L10nService.localizations.settingPlantSubTittle,
            SelectPlant(
              onPlantSelected: changePlant,
              userSetting: userSetting,
            ),
            context);
      case 1:
        return pageSetting(
            L10nService.localizations.settingPreferenceTittle,
            L10nService.localizations.settingFrecuencySubTittle,
            StressTest(
              changeStresstest: changeStressTest,
              userSetting: userSetting,
            ),
            context,
            pathImage: "assets/img/frecuencia_cuestionario.svg.vec");
      case 2:
        return pageSetting(
          L10nService.localizations.settingPreferenceTittle,
          L10nService.localizations.settingNotificationSubTittle,
          Notifications(
              userSetting: userSetting,
              changeNotificationTest: changeNotificationTest,
              changeNotificationActividades: changeNotificationActividades),
          context,
          pathImage: "assets/img/notification_setting.svg.vec",
        );
      case 3:
        return pageSetting(
          L10nService.localizations.settingPrivacyTittle,
          L10nService.localizations.settingPrivacySubTittle,
          Greenhouse(userSetting: userSetting, changeAccesoInvernadero: changeAccesoInvernadero),
          context,
          pathImage: "assets/img/frecuencia_cuestionario.svg.vec",
        );
      default:
        throw Exception("Invalid index");
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Llama a super.build para mantener el estado vivo
    return Consumer<SaveSettingsProvider>(builder: (context, saveSettingsProvider, child) {
      if (saveSettingsProvider.state == SaveSettingsState.loading) {
        return const LoadingScreen();
      }

      if (saveSettingsProvider.state == SaveSettingsState.error) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (BuildContext context) => alertDialog(
              saveSettingsProvider.errorMessage ?? "",
              context,
            ),
          );

          if (_pageController.hasClients) {
            _pageController.jumpToPage(currentPage);
          }

          saveSettingsProvider.resetState();
        });
      } else if (saveSettingsProvider.state == SaveSettingsState.loaded) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          nextPage();
          saveSettingsProvider
              .resetState(); // opcional, por si querés prevenir que se dispare de nuevo
        });
      }
      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Text(
            L10nService.localizations.basicSetting,
            style: TextStyle(color: textColor, fontFamily: 'Rubik', fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            progressIndicator(currentPage),
            Expanded(
              // Para que el PageView ocupe el espacio restante
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                itemCount: 4, // Total number of pages
                itemBuilder: (BuildContext context, int index) {
                  return buildPage(index, context);
                },
              ),
            ),
          ],
        ),
        persistentFooterButtons: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: widthPercentage(.8, context),
                height: heightPercentage(.05, context),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(61, 87, 50, .3),
                          blurRadius: 20,
                          offset: Offset(0, 12))
                    ]),
                child: TextButton(
                    onPressed: () {
                      if (currentPage == 3) {
                        saveSettings();
                      } else {
                        _pageController.animateToPage(_pageController.page!.toInt() + 1,
                            duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                      }
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(61, 87, 50, 1),
                        foregroundColor: const Color.fromRGBO(151, 193, 130, 1)),
                    child: Text(
                      currentPage == 3
                          ? L10nService.localizations.getStartedButton
                          : L10nService.localizations.confirmButton,
                      style: const TextStyle(fontFamily: "Rubik", color: Colors.white),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: heightPercentage(.02, context),
                        bottom: heightPercentage(.01, context)),
                    width: widthPercentage(.8, context),
                    height: heightPercentage(.05, context),
                    child: TextButton(
                        onPressed: () => {
                              _pageController.animateToPage(_pageController.page!.toInt() - 1,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut)
                            },
                        style: TextButton.styleFrom(
                            foregroundColor: const Color.fromRGBO(151, 193, 130, 1)),
                        child: Text(
                          L10nService.localizations.back,
                          style: const TextStyle(
                              color: Color.fromRGBO(61, 87, 50, 1), fontFamily: 'Rubik'),
                        )),
                  ),
                ],
              )
            ],
          )
        ],
      );
    });
  }
}

Widget progressIndicator(int currentPage) {
  BoxDecoration current = BoxDecoration(
      color: Colors.transparent,
      shape: BoxShape.circle,
      border: Border.all(color: const Color.fromRGBO(112, 112, 112, 1), width: 3));

  BoxDecoration prox = BoxDecoration(
      color: const Color.fromRGBO(174, 179, 176, 1),
      shape: BoxShape.circle,
      border: Border.all(color: const Color.fromRGBO(174, 179, 176, 1), width: 3));

  BoxDecoration passed = BoxDecoration(
      color: const Color.fromRGBO(112, 112, 112, 1),
      shape: BoxShape.circle,
      border: Border.all(color: const Color.fromRGBO(112, 112, 112, 1), width: 3));

  Container line = Container(
    width: 40.0,
    height: 1.0,
    color: const Color.fromRGBO(160, 160, 160, 1),
  );

  TextStyle textGrey = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(112, 112, 112, 1),
  );
  TextStyle textWhite = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return [
          (index > 0) ? line : const SizedBox.shrink(),
          Container(
            padding: const EdgeInsets.all(13),
            decoration: index == currentPage
                ? current
                : index > currentPage
                    ? prox
                    : passed,
            child: Text(
              (index + 1).toString(),
              textAlign: TextAlign.center,
              style: index == currentPage ? textGrey : textWhite,
            ),
          )
        ];
      }).expand((element) => element).toList());
}
