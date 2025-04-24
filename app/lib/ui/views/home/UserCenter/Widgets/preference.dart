import 'package:care4plant/ui/provider/preference_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/services/l10n/l10n_service.dart';
import 'custom_switch_frecuencia_test.dart';

class Preference extends StatefulWidget {
  final Function(int) setExpanded;
  final int isExpanded;
  const Preference({Key? key, required this.isExpanded, required this.setExpanded})
      : super(key: key);

  @override
  PreferenceState createState() => PreferenceState();
}

class PreferenceState extends State<Preference> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceProvider>(builder: (context, provider, child) {
      return Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .03),
        width: MediaQuery.of(context).size.width * .9,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 6, // Radio de desenfoque de la sombra
              spreadRadius: 1, // Radio de expansión de la sombra
              offset: const Offset(0, 6),
            )
          ],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: const Color.fromRGBO(219, 227, 219, 1),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                widget.setExpanded(1);
              },
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      L10nService.localizations.preferencesUserCenter,
                      style: const TextStyle(
                          color: Color.fromRGBO(61, 87, 50, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    AnimatedRotation(
                      turns: (widget.isExpanded == 1) ? -.25 : 0,
                      duration: const Duration(milliseconds: 400),
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color.fromRGBO(108, 117, 108, 1),
                      ),
                    )
                  ],
                ),
              ),
            ),
            (provider.semanaFrecuenciaTest != null && provider.frecuenciaTest != null)
                ? AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linearToEaseOut,
                    child: Container(
                      margin: (widget.isExpanded == 1) ? const EdgeInsets.only(top: 10) : null,
                      child: (widget.isExpanded == 1)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  L10nService.localizations.userCenterFrecuency,
                                  style: const TextStyle(
                                      fontSize: 17, color: Color.fromRGBO(61, 87, 50, 1)),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                        child: Text(
                                      L10nService.localizations.userCenterOnceWeek,
                                      style: const TextStyle(
                                          fontSize: 17, color: Color.fromRGBO(61, 87, 50, 1)),
                                    )),
                                    customSwitchFrecuenciaTest(
                                        (provider.semanaFrecuenciaTest == 1 &&
                                            provider.frecuenciaTest == 1),
                                        1,
                                        1,
                                        provider.setFrecuenciaTest)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                        child: Text(
                                      L10nService.localizations.userCenterTwiceWeek,
                                      style: const TextStyle(
                                          fontSize: 17, color: Color.fromRGBO(61, 87, 50, 1)),
                                    )),
                                    customSwitchFrecuenciaTest(
                                        (provider.semanaFrecuenciaTest == 1 &&
                                            provider.frecuenciaTest == 2),
                                        1,
                                        2,
                                        provider.setFrecuenciaTest)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                        child: Text(
                                      L10nService.localizations.userCenterOnceTwoWeek,
                                      style: const TextStyle(
                                          color: Color.fromRGBO(61, 87, 50, 1), fontSize: 17),
                                    )),
                                    customSwitchFrecuenciaTest(
                                        (provider.semanaFrecuenciaTest == 2 &&
                                            provider.frecuenciaTest == 1),
                                        2,
                                        1,
                                        provider.setFrecuenciaTest)
                                  ],
                                )
                              ],
                            )
                          : const SizedBox.shrink(),
                    ),
                  )
                : Container()
          ],
        ),
      );
    });
  }
}
