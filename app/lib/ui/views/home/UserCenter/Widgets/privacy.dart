import 'package:care4plant/ui/provider/privacy_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/services/l10n/l10n_service.dart';
import 'custom_switch_invernadero.dart';

class Privacy extends StatefulWidget {
  final Function(int) setExpanded;
  final int isExpanded;
  const Privacy({Key? key, required this.setExpanded, required this.isExpanded}) : super(key: key);

  @override
  PrivacyState createState() => PrivacyState();
}

class PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PrivacyProvider>(builder: (context, provider, child) {
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
                widget.setExpanded(2);
              },
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      L10nService.localizations.privacyUserCenter,
                      style: const TextStyle(
                          color: Color.fromRGBO(61, 87, 50, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    AnimatedRotation(
                      turns: (widget.isExpanded == 2) ? -.25 : 0,
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
            (provider.accesoInvernadero != null)
                ? AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linearToEaseOut,
                    child: Container(
                      margin: (widget.isExpanded == 2) ? const EdgeInsets.only(top: 10) : null,
                      child: (widget.isExpanded == 2)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    child: Text(
                                  L10nService.localizations.sharePlant,
                                  style: const TextStyle(
                                      fontSize: 17, color: Color.fromRGBO(61, 87, 50, 1)),
                                )),
                                customSwitchInvernadero(
                                    provider.accesoInvernadero!, provider.setAccesoInvernadero)
                              ],
                            )
                          : const SizedBox.shrink(),
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      );
    });
  }
}
