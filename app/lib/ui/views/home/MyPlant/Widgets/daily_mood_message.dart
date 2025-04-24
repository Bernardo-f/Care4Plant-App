import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/services/l10n/l10n_service.dart';
import '../../../../provider/get_reporte_diario_provider.dart';
import '../../../helpers/layout_helpers.dart';

class DailyMoodMessage extends StatefulWidget {
  final Function(int) changeTab;
  const DailyMoodMessage({Key? key, required this.changeTab}) : super(key: key);

  @override
  DailyMoodMessageState createState() => DailyMoodMessageState();
}

class DailyMoodMessageState extends State<DailyMoodMessage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GetReporteDiarioProvider>(builder: (context, state, child) {
      if (state.isLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.reporteDiario == null) {
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
                      L10nService.localizations.dailyMoodTitle,
                      style: const TextStyle(
                          color: Color.fromRGBO(61, 87, 50, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.5),
                    ),
                    Text(
                      L10nService.localizations.dailyMoodSubTitle,
                      style: const TextStyle(
                          color: Color.fromRGBO(58, 60, 62, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
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
                      widget.changeTab(2);
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
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
