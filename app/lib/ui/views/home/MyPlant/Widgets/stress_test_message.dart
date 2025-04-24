import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/services/l10n/l10n_service.dart';
import '../../../../../injection_container.dart';
import '../../../../provider/register_stress_test_provider.dart';
import '../../../../provider/validate_date_test_provider.dart';
import '../../../helpers/layout_helpers.dart';
import '../../../stressleveltest/stress_level_test.dart';

class StressTestMessage extends StatefulWidget {
  const StressTestMessage({Key? key}) : super(key: key);

  @override
  StressTestMessageState createState() => StressTestMessageState();
}

class StressTestMessageState extends State<StressTestMessage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ValidateDateTestProvider>(builder: (context, provider, child) {
      if (provider.state == ValidateDateTestState.loading) {
        return const CircularProgressIndicator();
      } else if (provider.state == ValidateDateTestState.error) {
        return const SizedBox.shrink();
      } else if (provider.isValidDateTest == true) {
        return Container(
            margin: const EdgeInsets.only(top: 31),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(4, 5),
                    blurRadius: 6,
                  ),
                ],
                color: const Color.fromRGBO(227, 235, 228, 1),
                borderRadius: BorderRadius.circular(25)),
            width: widthPercentage(.9, context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      L10nService.localizations.stressTestMessageTitle,
                      style: const TextStyle(
                          color: Color.fromRGBO(61, 87, 50, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.5),
                    ),
                    Text(
                      L10nService.localizations.stressTestMessageSubTitle,
                      style: const TextStyle(
                        color: Color.fromRGBO(58, 60, 62, 1),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                )),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: const Color.fromRGBO(61, 87, 50, 1), width: 2.0)),
                  child: IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                    create: (_) =>
                                        RegisterStressTestProvider(registerStressTestUseCase: sl()),
                                    child: const StressLevelTest(redirect: false),
                                  )));
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
            ));
      }
      return const SizedBox.shrink();
    });
  }
}
