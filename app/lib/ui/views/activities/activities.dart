import 'package:care4plant/env.dart';
import 'package:care4plant/injection_container.dart';
import 'package:care4plant/models/actividad.dart';
import 'package:care4plant/models/categoria.dart';
import 'package:care4plant/models/visita.dart';
import 'package:care4plant/ui/provider/add_ingreso_actividad_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../core/services/l10n/l10n_service.dart';
import '../../provider/get_actividades_by_categoria_provider.dart';
import '../../provider/log_visita_provider.dart';
import '../components/circular_primary_indicator.dart';
import '../helpers/format_duration.dart';
import '../helpers/layout_helpers.dart';
import '../theme/app_colors.dart';
import 'Layouts/meditacion_layout.dart';
import 'Layouts/music_terapy_layout.dart';
import 'Layouts/text_layout.dart';

class Activities extends StatefulWidget {
  final Categoria categoria;
  const Activities({Key? key, required this.categoria}) : super(key: key);

  @override
  ActivitiesState createState() => ActivitiesState();
}

class ActivitiesState extends State<Activities> with WidgetsBindingObserver {
  late Future<List<Actividad>?> actividadList;
  DateTime fechavisita = DateTime.now();
  bool _flagLog = false; // Indica si se ha enviado el log
  final Stopwatch _stopwatch = Stopwatch();
  final scrollController = ScrollController();
  late LogVisitaProvider logVisitaProvider;

  @override
  void initState() {
    super.initState();
    _stopwatch.start();
    logVisitaProvider = LogVisitaProvider(logVisitaUseCase: sl());
    WidgetsBinding.instance
        .addObserver(this); // Importante, para que funcione el didChangeAppLifecycleState
  }

  void saveVisita(Duration tiempovisita) async {
    final Visita visita = Visita(
        id_categoria: widget.categoria.id_categoria,
        fecha_visita: fechavisita,
        tiempo_visita: tiempovisita);
    await Provider.of<LogVisitaProvider>(context, listen: false).logVisita(visita);
  }

  @override
  void dispose() {
    _stopwatch.stop();

    if (!_flagLog) {
      final tiempo = _stopwatch.elapsed;

      final visita = Visita(
        id_categoria: widget.categoria.id_categoria,
        fecha_visita: fechavisita,
        tiempo_visita: tiempo,
      );

      // Ya no usamos Future, ni microtask ni callbacks
      logVisitaProvider.logVisita(visita);
    }

    scrollController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if ((state == AppLifecycleState.inactive ||
            state == AppLifecycleState.paused ||
            // state == AppLifecycleState.hidden ||
            state == AppLifecycleState.detached) &&
        !(_flagLog)) {
      _stopwatch.stop();
      _flagLog = true;
      saveVisita(_stopwatch.elapsed);
    }
    if (state == AppLifecycleState.resumed && _flagLog) {
      fechavisita = DateTime.now();
      _flagLog = false;
      _stopwatch.reset();
      _stopwatch.start();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetActividadesByCategoriaProvider>(builder: (context, provider, child) {
      return Scaffold(
        backgroundColor: const Color.fromRGBO(227, 235, 228, 1),
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          toolbarHeight: 80,
          leading: Align(
            alignment: Alignment.topCenter,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Color.fromRGBO(93, 94, 93, 1),
                )),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.categoria.nombre_categoria,
                style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(58, 60, 62, 1),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 200,
                child: Text(
                  widget.categoria.descripcion_categoria,
                  maxLines: 2,
                  style: const TextStyle(
                      color: Color.fromRGBO(110, 112, 115, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 90),
              padding: const EdgeInsets.only(top: 100),
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(193, 202, 195, 1),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    (provider.state == GetActividadesByCategoriaState.loading)
                        ? const Center(
                            heightFactor: 10,
                            child: circularPrimaryColorIndicator,
                          )
                        : (provider.state == GetActividadesByCategoriaState.error)
                            ? const Text("No data available")
                            : (provider.actividades != null)
                                ? (provider.actividades!.isNotEmpty)
                                    ? buildRecommended(
                                        provider.actividades![0], widget.categoria, context,
                                        actividades: provider.actividades)
                                    : const SizedBox.shrink()
                                : const SizedBox.shrink(),
                    Container(
                      margin:
                          EdgeInsets.only(top: heightPercentage(.01, context), left: 30, right: 30),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        L10nService.localizations.exploreMore,
                        style: const TextStyle(
                            color: Color.fromRGBO(58, 60, 62, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    (provider.state == GetActividadesByCategoriaState.loading)
                        ? const Center(
                            heightFactor: 10,
                            child: CircularProgressIndicator(),
                          )
                        : (provider.state == GetActividadesByCategoriaState.error)
                            ? const Text("No data available")
                            : (provider.actividades != null)
                                ? (provider.actividades!.isNotEmpty)
                                    ? Container(
                                        margin:
                                            EdgeInsets.only(top: heightPercentage(.01, context)),
                                        height: 300,
                                        child: buildActividades(provider.actividades!,
                                            widget.categoria, scrollController))
                                    : const SizedBox.shrink()
                                : const SizedBox.shrink(),
                  ],
                )),
              ),
            ),
            Positioned(
              child: Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.network(
                  apiUrl + widget.categoria.imagen_categoria,
                  width: 180,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

Widget buildRecommended(Actividad actividad, Categoria categoria, BuildContext context,
    {List<Actividad>? actividades}) {
  return Container(
    margin: EdgeInsets.only(
        left: 20,
        right: 20,
        top: heightPercentage(.02, context),
        bottom: heightPercentage(.01, context)),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            offset: const Offset(4, 5),
            blurRadius: 6,
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: const Color.fromRGBO(227, 235, 228, 1)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        L10nService.localizations.recommendedForYou,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 160,
            margin: const EdgeInsets.only(top: 5, right: 10),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color.fromRGBO(151, 181, 157, .69)),
            child: SvgPicture.network(apiUrl + actividad.imagen_actividad),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                actividad.nombre_actividad,
                style: const TextStyle(
                    color: Color.fromRGBO(58, 60, 62, 1),
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
              Text(
                actividad.descripcion_actividad,
                style: const TextStyle(fontSize: 16),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDuration(actividad.tiempo_actividad),
                    style: const TextStyle(fontSize: 16),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color.fromRGBO(93, 109, 97, 1)),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: ((context) {
                          switch (categoria.layout_categoria) {
                            case 3:
                              return ChangeNotifierProvider(
                                  create: (_) =>
                                      AddIngresoActividadProvider(addIngresoActividadUseCase: sl()),
                                  child: TextLayout(
                                    actividad: actividad,
                                  ));
                            case 2:
                              return ChangeNotifierProvider(
                                  create: (_) =>
                                      AddIngresoActividadProvider(addIngresoActividadUseCase: sl()),
                                  child: Meditacion(
                                    actividad: actividad,
                                    categoria: categoria,
                                  ));
                            case 4:
                              return ChangeNotifierProvider(
                                create: (_) =>
                                    AddIngresoActividadProvider(addIngresoActividadUseCase: sl()),
                                child: Music(
                                  index: 0,
                                  actividades: actividades!,
                                  categoria: categoria,
                                ),
                              );

                            default:
                              return Container(
                                color: primaryColor,
                                child: const Text("Ocurrio un error"),
                              );
                          }
                        })));
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )
            ],
          )),
        ],
      )
    ]),
  );
}

Widget buildActividades(
    List<Actividad> actividades, Categoria categoria, ScrollController scrollController) {
  return Scrollbar(
    thumbVisibility: true,
    controller: scrollController,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actividades.length,
        controller: scrollController,
        itemBuilder: (context, index) {
          final actividad = actividades[index];
          return ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: 190,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      offset: const Offset(4, 5),
                      blurRadius: 6,
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  color: const Color.fromRGBO(227, 235, 228, 1)),
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 120,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromRGBO(151, 181, 157, .69)),
                      child: SvgPicture.network(
                        apiUrl + actividad.imagen_actividad,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        actividad.nombre_actividad,
                        style: const TextStyle(
                            color: Color.fromRGBO(58, 60, 62, 1),
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                actividad.descripcion_actividad,
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                formatDuration(actividad.tiempo_actividad),
                                style: const TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color.fromRGBO(93, 109, 97, 1)),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                                switch (categoria.layout_categoria) {
                                  case 3:
                                    return ChangeNotifierProvider(
                                        create: (_) => AddIngresoActividadProvider(
                                            addIngresoActividadUseCase: sl()),
                                        child: TextLayout(
                                          actividad: actividad,
                                        ));
                                  case 2:
                                    return ChangeNotifierProvider(
                                        create: (_) => AddIngresoActividadProvider(
                                            addIngresoActividadUseCase: sl()),
                                        child: Meditacion(
                                          actividad: actividad,
                                          categoria: categoria,
                                        ));
                                  case 4:
                                    return ChangeNotifierProvider(
                                      create: (_) => AddIngresoActividadProvider(
                                          addIngresoActividadUseCase: sl()),
                                      child: Music(
                                        index: index,
                                        actividades: actividades,
                                        categoria: categoria,
                                      ),
                                    );
                                  default:
                                    return Container(
                                      color: primaryColor,
                                      child: const Text("Ocurrio un error"),
                                    );
                                }
                              })));
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    )
                  ]),
            ),
          );
        }),
  );
}
