import 'package:care4plant/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/l10n/l10n_service.dart';
import '../../../../domain/usecases/validate_date_test_usecase.dart';
import '../../../provider/get_categorias_provider.dart';
import '../../../provider/reporte_diario_provider.dart';
import '../../../provider/validate_date_test_provider.dart';
import 'Widgets/daily_mood.dart';
import 'Widgets/list_categorias.dart';
import 'Widgets/take_test.dart';

class CareCenter extends StatefulWidget {
  const CareCenter({Key? key}) : super(key: key);

  @override
  CareCenterState createState() => CareCenterState();
}

class CareCenterState extends State<CareCenter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.elliptical(30, 30), topRight: Radius.elliptical(30, 30)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.3),
                blurRadius: 7,
                spreadRadius: 3,
                offset: const Offset(0, 2))
          ],
          color: const Color.fromRGBO(227, 235, 228, 1)),
      child: Column(children: [
        ChangeNotifierProvider(
            create: (_) =>
                ReporteDiarioProvider(getReporteDiarioUseCase: sl(), addReporteDiarioUseCase: sl())
                  ..init(),
            child: const DailyMood()),
        Expanded(
            child: Container(
          margin: const EdgeInsets.only(
            top: 20,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(198, 207, 202, 1),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.elliptical(30, 30), topRight: Radius.elliptical(30, 30)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    blurRadius: 7,
                    spreadRadius: 3,
                    offset: const Offset(0, 2))
              ]),
          child: Column(
            children: [
              ChangeNotifierProvider(
                  create: (_) => ValidateDateTestProvider(
                      validateDateTestUseCase: sl<ValidateDateTestUseCase>())
                    ..init(),
                  child: const TakeTest()),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                child: Text(
                  L10nService.localizations.exploreMore,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(61, 87, 50, 1)),
                ),
              ),
              Expanded(
                  child: ChangeNotifierProvider(
                      create: (_) => GetCategoriasProvider(getCategoriasUseCase: sl())..init(),
                      child: const ListCategorias())),
            ],
          ),
        ))
      ]),
    );
  }
}
