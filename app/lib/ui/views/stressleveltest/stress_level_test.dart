// ignore_for_file: use_build_context_synchronously

import 'package:care4plant/ui/provider/get_plant_provider.dart';
import 'package:care4plant/ui/views/Home/home.dart';
import 'package:care4plant/ui/views/onboarding/welcome_message.dart';
import 'package:care4plant/ui/views/stressleveltest/Widgets/question_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../../../core/services/l10n/l10n_service.dart';
import '../../../injection_container.dart';
import '../../../models/stress_test.dart';
import '../../provider/register_stress_test_provider.dart';
import '../components/alert_dialogs.dart';
import '../components/wave_loader.dart';
import '../helpers/layout_helpers.dart';
import '../theme/app_colors.dart';
import 'Widgets/progress_bar.dart';

class StressLevelTest extends StatefulWidget {
  final bool redirect;
  const StressLevelTest({Key? key, required this.redirect}) : super(key: key);

  @override
  StressLevelTestState createState() => StressLevelTestState();
}

class StressLevelTestState extends State<StressLevelTest> with AutomaticKeepAliveClientMixin {
  final storage = const FlutterSecureStorage();
  Stresstest stresstest = Stresstest();
  late PageController _pageController;
  double currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: currentPage.toInt(), keepPage: true, viewportFraction: 1.0);
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.toDouble();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void changeAnswer(int index, int value) {
    setState(() {
      stresstest.changeAnswer(index, value);
    });
  }

  void saveAnswer() async {
    if (!stresstest.validate()) {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              alertDialog(L10nService.localizations.validateTest, context));
      return;
    }
    stresstest.fechaTest = DateTime.now();

    final provider = Provider.of<RegisterStressTestProvider>(context, listen: false);

    provider.registerTest(stresstest);
  }

  @override
  bool get wantKeepAlive => true; // Keep the state of this widget alive

  void nextPage() {
    if (widget.redirect) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                    create: (_) => GetPlantProvider(getPlantUseCase: sl()),
                    child: WelcomeMessageView(
                      message: L10nService.localizations.postFirstTestMessage,
                      nextPageBuilder: () => const HomeView(),
                    ),
                  )),
          (Route<dynamic> route) => false);
    } else {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => const HomeView()), ModalRoute.withName('/'));
    }
  }

  Widget buildPage(int index) {
    switch (index) {
      case 0:
        return QuestionTest(
            question: L10nService.localizations.question1,
            changeAnswer: changeAnswer,
            stresstest: stresstest,
            indexQuestion: index + 1);
      case 1:
        return QuestionTest(
            question: L10nService.localizations.question2,
            changeAnswer: changeAnswer,
            stresstest: stresstest,
            indexQuestion: index + 1);
      case 2:
        return QuestionTest(
            question: L10nService.localizations.question3,
            changeAnswer: changeAnswer,
            stresstest: stresstest,
            indexQuestion: index + 1);
      case 3:
        return QuestionTest(
            question: L10nService.localizations.question4,
            changeAnswer: changeAnswer,
            stresstest: stresstest,
            indexQuestion: index + 1);
      case 4:
        return QuestionTest(
            question: L10nService.localizations.question5,
            changeAnswer: changeAnswer,
            stresstest: stresstest,
            indexQuestion: index + 1);
      case 5:
        return QuestionTest(
            question: L10nService.localizations.question6,
            changeAnswer: changeAnswer,
            stresstest: stresstest,
            indexQuestion: index + 1);
      default:
        throw Exception("Invalid index");
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<RegisterStressTestProvider>(builder: (context, provider, child) {
      if (provider.state == RegisterStressTestState.loading) {
        return const LoadingScreen();
      } else if (provider.state == RegisterStressTestState.error) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
              context: context,
              builder: (BuildContext context) => alertDialog(provider.errorMessage ?? "", context));
          if (_pageController.hasClients) {
            _pageController.jumpToPage(currentPage.toInt());
          }

          provider.resetState();
        });
      } else if (provider.state == RegisterStressTestState.success) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          nextPage();
        });
      }
      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          shadowColor: Colors.black,
          centerTitle: true,
          toolbarHeight: 80,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80))),
          title: Text(
            L10nService.localizations.testTitle,
            style: const TextStyle(
                color: Color.fromRGBO(61, 87, 50, 1),
                fontFamily: "Monserrat",
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .03),
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color.fromRGBO(242, 242, 242, 1)),
                  child: const Icon(
                    Icons.volunteer_activism,
                    size: 30,
                    color: Color.fromRGBO(91, 95, 89, 1),
                  ),
                ),
                Text(
                  L10nService.localizations.testSubTitle,
                  style: const TextStyle(
                      fontFamily: "Rubik",
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(58, 60, 62, 1)),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * .03,
                  top: MediaQuery.of(context).size.height * .02),
              child: ProgressBar(
                progressValue: currentPage.toInt() + 1,
              ),
            ),
            SizedBox(
              height: heightPercentage(.65, context),
              child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    return buildPage(index);
                  }),
            )
          ]),
        ),
        persistentFooterButtons: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(112, 182, 150, 0.3),
                          offset: Offset(0, 12),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    width: MediaQuery.of(context).size.width * .8,
                    height: MediaQuery.of(context).size.height * .05,
                    child: TextButton(
                      onPressed: () => {
                        if (currentPage == 5)
                          {saveAnswer()}
                        else
                          {
                            _pageController.nextPage(
                                duration: const Duration(seconds: 1), curve: Curves.easeInOut)
                          }
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(61, 87, 50, 1),
                          foregroundColor: const Color.fromRGBO(151, 193, 130, 1)),
                      child: Text(
                        L10nService.localizations.nextButtton,
                        style: const TextStyle(
                            color: Colors.white, fontFamily: 'Rubik', fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: heightPercentage(.02, context)),
                    width: widthPercentage(.8, context),
                    height: heightPercentage(.04, context),
                    child: ElevatedButton(
                        onPressed: () => {
                              _pageController.previousPage(
                                  duration: const Duration(seconds: 1), curve: Curves.easeInOut)
                            },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: const Color.fromRGBO(151, 193, 130, 1),
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            elevation: 0),
                        child: Text(
                          L10nService.localizations.back,
                          style: const TextStyle(
                              color: Color.fromRGBO(61, 87, 50, 1),
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
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
