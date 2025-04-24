import 'package:care4plant/ui/provider/validate_date_test_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/services/l10n/l10n_service.dart';
import '../../../stressleveltest/stress_level_test.dart';

class TakeTest extends StatefulWidget {
  const TakeTest({Key? key}) : super(key: key);

  @override
  TakeTestState createState() => TakeTestState();
}

class TakeTestState extends State<TakeTest> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ValidateDateTestProvider>(builder: (context, provider, child) {
      if (provider.state == ValidateDateTestState.loading) {
        return const CircularProgressIndicator();
      } else if (provider.state == ValidateDateTestState.error) {
        return const SizedBox.shrink();
      } else if (provider.isValidDateTest == true) {
        return Container(
          margin: const EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 10),
          decoration: const BoxDecoration(
              borderRadius:
                  BorderRadius.horizontal(left: Radius.circular(50), right: Radius.circular(20)),
              color: Color.fromRGBO(237, 239, 238, 1)),
          child: Row(children: [
            Container(
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              padding: const EdgeInsets.all(20),
              child: const Icon(
                Icons.volunteer_activism_rounded,
                size: 35,
                color: Color.fromRGBO(91, 95, 89, 1),
              ),
            ),
            Flexible(
                child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    L10nService.localizations.stressTestMessageTitle,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(61, 87, 50, 1),
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          L10nService.localizations.takeTestMessage,
                          style: const TextStyle(
                              color: Color.fromRGBO(61, 87, 50, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border:
                                Border.all(color: const Color.fromRGBO(61, 87, 50, 1), width: 2.0)),
                        child: IconButton(
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const StressLevelTest(redirect: false)));
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Color.fromRGBO(61, 87, 50, 1),
                            textDirection: TextDirection.rtl,
                          ),
                          iconSize: 25,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )),
          ]),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
