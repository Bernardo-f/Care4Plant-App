import 'package:care4plant/domain/usecases/get_reporte_diario_usecase.dart';
import 'package:care4plant/ui/provider/get_categorias_recomendadas_provider.dart';
import 'package:care4plant/ui/provider/get_reporte_diario_provider.dart';
import 'package:care4plant/ui/provider/validate_date_test_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../../../../domain/usecases/get_categorias_recomendadas_usecase.dart';
import '../../../../domain/usecases/validate_date_test_usecase.dart';
import '../../../../injection_container.dart';
import '../../../provider/plant_provider.dart';
import 'Widgets/categorias_recomendadas.dart';
import 'Widgets/daily_mood_message.dart';
import 'Widgets/message.dart';
import 'Widgets/plant.dart';
import 'Widgets/stress_test_message.dart';

class MyPlant extends StatefulWidget {
  final Function(int) changeTab;
  const MyPlant({Key? key, required this.changeTab}) : super(key: key);

  @override
  MyPlantState createState() => MyPlantState();
}

class MyPlantState extends State<MyPlant> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: SingleChildScrollView(
          child: Stack(
        children: [
          const Positioned(
              left: -200,
              top: -300,
              child: SvgPicture(
                AssetBytesLoader("assets/img/background_myPlant.svg.vec"),
                fit: BoxFit.none,
              )),
          Column(
            children: [
              const Message(),
              ChangeNotifierProvider(
                create: (_) => sl<PlantProvider>(),
                child: const Plant(),
              ),
              ChangeNotifierProvider(
                  create: (_) => GetReporteDiarioProvider(
                      getReporteDiarioUseCase: sl<GetReporteDiarioUseCase>())
                    ..init(),
                  child: DailyMoodMessage(
                    changeTab: widget.changeTab,
                  )),
              //const StressTestMessage(),
              ChangeNotifierProvider(
                  create: (_) => ValidateDateTestProvider(
                      validateDateTestUseCase: sl<ValidateDateTestUseCase>())
                    ..init(),
                  child: const StressTestMessage()),
              ChangeNotifierProvider(
                  create: (_) => GetCategoriasRecomendadasProvider(
                      getCategoriasRecomendadasUseCase: sl<GetCategoriasRecomendadasUseCase>())
                    ..init(),
                  child: CategoriasRecomendadas(
                    changeTab: widget.changeTab,
                  )),
              const Padding(padding: EdgeInsets.all(10))
            ],
          ),
        ],
      )),
    );
  }
}
