import 'dart:convert';
import 'package:care4plant/env.dart';
import 'package:care4plant/models/actividad.dart';
import 'package:care4plant/ui/provider/add_ingreso_actividad_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:vector_graphics/vector_graphics.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../../core/services/l10n/l10n_service.dart';
import '../../helpers/format_duration.dart';

class TextLayout extends StatefulWidget {
  final Actividad actividad;
  const TextLayout({Key? key, required this.actividad}) : super(key: key);

  @override
  TextLayoutState createState() => TextLayoutState();
}

class TextLayoutState extends State<TextLayout> {
  bool finazalida = false;
  late Timer _timer;
  late AddIngresoActividadProvider provider;

  Future<String?> getText() async {
    final response = await http.get(Uri.parse(apiUrl + widget.actividad.contenido_actividad));
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  Timer scheduleTimeout() => Timer(widget.actividad.tiempo_actividad, handleTimeout);

  @override
  void initState() {
    WakelockPlus.toggle(enable: true);
    provider = Provider.of<AddIngresoActividadProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    if (finazalida == false) {
      handleNoFinalizada();
    }
    WakelockPlus.disable();
    super.dispose();
  }

  void handleTimeout() async {
    provider.addIngresoActividad(widget.actividad.id_actividad, true);
    finazalida = true;
  }

  void handleNoFinalizada() async {
    provider.addIngresoActividad(widget.actividad.id_actividad, false);
  }

  void showMessage(String action) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(60), bottomLeft: Radius.circular(60))),
          backgroundColor: const Color.fromRGBO(237, 247, 237, 1),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      child: const Icon(Icons.close),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture(
                      AssetBytesLoader("assets/img/icon_recompensa.svg.vec"),
                      fit: BoxFit.cover,
                    )
                  ],
                ),
                Text(
                  L10nService.localizations.messageReward(action),
                  style: const TextStyle(
                      fontFamily: "Segoe UI", fontWeight: FontWeight.bold, fontSize: 19),
                )
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => const Color.fromRGBO(61, 87, 59, 1)),
                      shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Ajusta el radio para obtener una forma de "pill"
                      ))),
                  child: Text(
                    L10nService.localizations.useReward(action),
                    style: const TextStyle(color: Colors.white, fontFamily: "Segoe UI"),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil("home", ModalRoute.withName("/"));
                  },
                ),
                TextButton(
                  style: ButtonStyle(
                      shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Ajusta el radio para obtener una forma de "pill"
                    side: const BorderSide(
                        color: Color.fromRGBO(61, 87, 50, 1),
                        width: 1.0), // Agrega un borde de color negro con ancho de 2.0
                  ))),
                  child: Text(
                    L10nService.localizations.useLater,
                    style: const TextStyle(
                        color: Color.fromRGBO(61, 87, 50, 1), fontFamily: "Segoe UI"),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddIngresoActividadProvider>(builder: ((context, value, child) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (value.state == AddIngresoActividadState.loading ||
            value.state == AddIngresoActividadState.error) {
          showMessage(value.message ?? "");
        }
      });
      return Scaffold(
        backgroundColor: const Color.fromRGBO(227, 235, 228, 1),
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          toolbarHeight: 80,
          leading: Align(
            alignment: Alignment.center,
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
                widget.actividad.nombre_actividad,
                style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(58, 60, 62, 1),
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.actividad.descripcion_actividad,
                      maxLines: 2,
                      style: const TextStyle(
                          color: Color.fromRGBO(110, 112, 115, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      formatDuration(widget.actividad.tiempo_actividad),
                      style: const TextStyle(color: Color.fromRGBO(58, 60, 62, 1), fontSize: 15),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        body: Stack(children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.only(top: 100),
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.13),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(193, 202, 195, 1),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(227, 235, 228, 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 4,
                        offset: const Offset(4, 5),
                        blurRadius: 6,
                      ),
                    ],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(29),
                    )),
                child: FutureBuilder(
                    future: getText(),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        if (finazalida == false) {
                          _timer = scheduleTimeout();
                        }
                        return Text(
                          const Utf8Decoder().convert(snapshot.data!.codeUnits),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        );
                      }
                      return const SizedBox.shrink();
                    })),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: SvgPicture.network(
              apiUrl + widget.actividad.imagen_actividad,
              width: 150,
              fit: BoxFit.contain,
            ),
          ),
        ]),
      );
    }));
  }
}
