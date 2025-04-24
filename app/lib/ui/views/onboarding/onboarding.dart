import 'package:care4plant/ui/views/onboarding/basic_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_graphics/vector_graphics.dart';

import '../../../core/services/l10n/l10n_service.dart';
import '../../../injection_container.dart';
import '../../provider/get_all_plants_provider.dart';
import '../../provider/save_settings_provider.dart';
import '../helpers/layout_helpers.dart';
import 'components/page_onboarding.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  OnboardingViewState createState() => OnboardingViewState();
}

class OnboardingViewState extends State<OnboardingView> {
  final _pageController = PageController(initialPage: 0, keepPage: true, viewportFraction: 1.0);
  double currentPage = 0;
  @override
  void initState() {
    super.initState();
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

  Widget buildPage(int index) {
    switch (index) {
      case 0:
        return PageOnboarding(
          "assets/img/onboarding-1.svg.vec",
          L10nService.localizations.onboardingTittle1,
          L10nService.localizations.onboardingSubTittle1,
          L10nService.localizations.onboardingText1,
          currentPage,
        );
      case 1:
        return PageOnboarding(
          "assets/img/onboarding-2.svg.vec",
          L10nService.localizations.onboardingTittle2,
          L10nService.localizations.onboardingSubTittle2,
          L10nService.localizations.onboardingText2,
          currentPage,
        );
      case 2:
        return PageOnboarding(
          "assets/img/onboarding-3.svg.vec",
          L10nService.localizations.onboardingTittle3,
          L10nService.localizations.onboardingSubTittle3,
          L10nService.localizations.onboardingText3,
          currentPage,
        );
      case 3:
        return PageOnboarding(
          "assets/img/onboarding-4.svg.vec",
          L10nService.localizations.onboardingTittle4,
          L10nService.localizations.onboardingSubTittle4,
          L10nService.localizations.onboardingText4,
          currentPage,
        );
      default:
        throw Exception("Invalid index");
    }
  }

  @override
  Widget build(BuildContext context) {
    void redirectToBasicSettings() {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => MultiProvider(providers: [
                    ChangeNotifierProvider(
                        create: (_) => SaveSettingsProvider(saveSettingsUseCase: sl())),
                    ChangeNotifierProvider(
                        create: (_) => GetAllPlantsProvider(sl())..getAllPlants()),
                  ], child: const BasicSettingsView())),
          (Route<dynamic> route) => false);
    }

    return Scaffold(
      body: Stack(
        children: [
          BackgroundImage(
            pageCount: 4,
            offset: currentPage,
          ),
          PageView.builder(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return buildPage(index);
            },
            itemCount: 4, // Total number of pages
          )
        ],
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
                      if (currentPage == 3)
                        {
                          redirectToBasicSettings(),
                        }
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
                  margin: EdgeInsets.only(
                      top: heightPercentage(.02, context), bottom: heightPercentage(.01, context)),
                  width: widthPercentage(.8, context),
                  height: heightPercentage(.05, context),
                  child: TextButton(
                      onPressed: () => {
                            redirectToBasicSettings(),
                          },
                      style: TextButton.styleFrom(
                          foregroundColor: const Color.fromRGBO(151, 193, 130, 1)),
                      child: Text(
                        L10nService.localizations.skipTour,
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
  }
}

//Para la imagen de fondo con efecto de avance
//Referencia: https://moosch.io/articles/flutter-parallax-pageview/
class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
    required this.pageCount,
    //required this.screenSize,
    required this.offset,
  }) : super(key: key);

  /// Size of page
  //final Size screenSize;

  /// Number of pages
  final int pageCount;

  /// Currnet page position
  final double offset;

  @override
  Widget build(BuildContext context) {
    // Image aligment goes from -1 to 1.
    // We convert page number range, 0..6 into the image alignment range -1..1
    int lastPageIdx = pageCount - 1;
    int firstPageIdx = 0;
    int alignmentMax = 1;
    int alignmentMin = -1;
    int pageRange = (lastPageIdx - firstPageIdx);
    int alignmentRange = (alignmentMax - alignmentMin);
    double alignment = (((offset - firstPageIdx) * alignmentRange) / pageRange) + alignmentMin;

    return Container(
      margin: EdgeInsets.only(top: heightPercentage(.1, context)),
      width: double.infinity,
      child: SvgPicture(
        const AssetBytesLoader("assets/img/background-onboarding.svg.vec"),
        alignment: Alignment(alignment, 0),
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
