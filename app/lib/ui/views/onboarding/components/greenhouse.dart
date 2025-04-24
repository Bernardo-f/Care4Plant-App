import 'package:care4plant/models/user_settings.dart';

import 'package:flutter/material.dart';

import '../../../../core/services/l10n/l10n_service.dart';
import 'page_settings.dart';

class Greenhouse extends StatefulWidget {
  final UserSetting userSetting;
  final Function(bool) changeAccesoInvernadero;
  const Greenhouse({Key? key, required this.userSetting, required this.changeAccesoInvernadero})
      : super(key: key);

  @override
  GreenhouseState createState() => GreenhouseState();
}

const TextStyle textStyle =
    TextStyle(fontFamily: "Open Sans", color: Color.fromRGBO(107, 103, 122, 1), fontSize: 19);

class GreenhouseState extends State<Greenhouse> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          L10nService.localizations.sharePlant,
          style: textStyle,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  widget.changeAccesoInvernadero(true);
                },
                child: Row(
                  children: [
                    Radio<bool?>(
                      activeColor: Colors.black,
                      onChanged: (value) {
                        widget.changeAccesoInvernadero(true);
                      },
                      value: true,
                      groupValue: widget.userSetting.accesoInvernadero,
                    ),
                    textOption(L10nService.localizations.yesOption)
                  ],
                )),
            GestureDetector(
                onTap: () {
                  widget.changeAccesoInvernadero(false);
                },
                child: Row(
                  children: [
                    Radio<bool?>(
                      activeColor: Colors.black,
                      onChanged: (value) {
                        widget.changeAccesoInvernadero(false);
                      },
                      value: false,
                      groupValue: widget.userSetting.accesoInvernadero,
                    ),
                    textOption(L10nService.localizations.noOption)
                  ],
                ))
          ],
        )
      ],
    );
  }
}
