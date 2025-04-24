import 'package:flutter/material.dart';

import 'package:care4plant/core/services/l10n/l10n_service.dart';
import 'package:care4plant/models/user_settings.dart';
import 'page_settings.dart';

class StressTest extends StatefulWidget {
  final Function(int, int) changeStresstest;
  final UserSetting userSetting;

  const StressTest({Key? key, required this.userSetting, required this.changeStresstest})
      : super(key: key);

  @override
  StressTestState createState() => StressTestState();
}

class StressTestState extends State<StressTest> {
  @override
  Widget build(BuildContext context) {
    int groupValue =
        getGroupValue(widget.userSetting.frecuenciaTest, widget.userSetting.semanaFrecuenciaTest);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          GestureDetector(
              onTap: () {
                widget.changeStresstest(1, 1);
              },
              child: Row(
                children: [
                  Radio<int>(
                    activeColor: Colors.black,
                    onChanged: (value) {
                      widget.changeStresstest(1, 1);
                    },
                    value: 1,
                    groupValue: groupValue,
                  ),
                  textOption(L10nService.localizations.onceWeek)
                ],
              )),
          GestureDetector(
              onTap: () {
                widget.changeStresstest(2, 1);
              },
              child: Row(
                children: [
                  Radio<int>(
                    activeColor: Colors.black,
                    onChanged: (value) {
                      widget.changeStresstest(2, 1);
                    },
                    value: 2,
                    groupValue: groupValue,
                  ),
                  textOption(L10nService.localizations.twiceWeek)
                ],
              )),
          GestureDetector(
              onTap: () {
                widget.changeStresstest(1, 2);
              },
              child: Row(
                children: [
                  Radio<int>(
                    activeColor: Colors.black,
                    onChanged: (value) {
                      widget.changeStresstest(1, 2);
                    },
                    value: 3,
                    groupValue: groupValue,
                  ),
                  textOption(L10nService.localizations.onceTwoWeek)
                ],
              ))
        ]),
      ],
    );
  }
}

int getGroupValue(frecuenciaTest, semanaFrecuenciaTest) {
  if (frecuenciaTest == 1 && semanaFrecuenciaTest == 1) {
    return 1;
  }
  if (frecuenciaTest == 2 && semanaFrecuenciaTest == 1) {
    return 2;
  }
  if (frecuenciaTest == 1 && semanaFrecuenciaTest == 2) {
    return 3;
  }
  return 0;
}
