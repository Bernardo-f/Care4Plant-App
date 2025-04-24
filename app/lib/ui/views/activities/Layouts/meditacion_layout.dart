import 'package:audioplayers/audioplayers.dart';
import 'package:care4plant/env.dart';
import 'package:care4plant/models/actividad.dart';
import 'package:care4plant/models/categoria.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vector_graphics/vector_graphics.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../../core/services/l10n/l10n_service.dart';
import '../../../provider/add_ingreso_actividad_provider.dart';
import '../../helpers/format_duration.dart';
import '../../helpers/layout_helpers.dart';

class Meditacion extends StatefulWidget {
  final Actividad actividad;
  final Categoria categoria;
  const Meditacion({Key? key, required this.actividad, required this.categoria}) : super(key: key);

  @override
  MeditacionState createState() => MeditacionState();
}

class MeditacionState extends State<Meditacion> with WidgetsBindingObserver {
  late AddIngresoActividadProvider provider;
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool finazalida = false;
  Duration maxDuracion = Duration.zero;
  Duration currentDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<AddIngresoActividadProvider>(context, listen: false);
    WidgetsBinding.instance
        .addObserver(this); // Importante, para que funcione el didChangeAppLifecycleState
    initPlayer();
    WakelockPlus.toggle(enable: true); // Para que la pantalla no se apague
    audioPlayer.onPlayerStateChanged.listen((state) async {
      if (state == PlayerState.paused || state == PlayerState.playing) {
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
      }
      if (state == PlayerState.completed) {
        if (finazalida == false) {
          finazalida = true;
          provider.addIngresoActividad(widget.actividad.id_actividad, true);
        }
        currentDuration = Duration.zero;
        await initPlayer();
        await audioPlayer.pause();
      }
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        maxDuracion = newDuration;
      });
    });

    // listen to audio position
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        currentDuration = newPosition;
      });
    });
  }

  Future<void> initPlayer() async {
    await audioPlayer.setSource(UrlSource(apiUrl + widget.actividad.contenido_actividad));
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
                    style: const TextStyle(
                        color: Colors.white, fontFamily: "Segoe UI", fontWeight: FontWeight.w600),
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
                        color: Color.fromRGBO(61, 87, 50, 1),
                        fontFamily: "Segoe UI",
                        fontWeight: FontWeight.w600),
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

  void handleNoFinalizada() async {
    await provider.addIngresoActividad(widget.actividad.id_actividad, false);
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    if (finazalida == false) {
      handleNoFinalizada();
    }
    audioPlayer.onDurationChanged.drain();
    audioPlayer.onPlayerStateChanged.drain();
    audioPlayer.onPositionChanged.drain();
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        // state == AppLifecycleState.hidden ||
        state == AppLifecycleState.detached) {
      audioPlayer.pause();
    }
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
                  width: 200,
                  margin: const EdgeInsets.only(right: 20),
                  child: Text(
                    widget.actividad.descripcion_actividad,
                    maxLines: 2,
                    style: const TextStyle(
                        color: Color.fromRGBO(110, 112, 115, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50),
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(193, 202, 195, 1),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  margin: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(227, 235, 228, 1),
                  ),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        formatDuration(widget.actividad.tiempo_actividad),
                        style: const TextStyle(fontSize: 16, color: Color.fromRGBO(58, 60, 62, 1)),
                      ),
                    ),
                    SvgPicture.network(
                      apiUrl + widget.actividad.imagen_actividad,
                      width: 250,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 5),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Text(
                              formatDuration(currentDuration),
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              formatDuration(maxDuracion),
                              style: const TextStyle(fontSize: 16),
                            )
                          ]),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                      child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            overlayShape: SliderComponentShape.noOverlay,
                            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                            trackHeight: 7,
                          ),
                          child: IgnorePointer(
                            child: Slider(
                              thumbColor: Colors.white,
                              activeColor: const Color.fromRGBO(93, 121, 100, 1),
                              inactiveColor: const Color.fromRGBO(193, 202, 195, 1),
                              value: currentDuration.inSeconds.toDouble(),
                              min: 0,
                              max: maxDuracion.inSeconds.toDouble(),
                              onChanged: (value) {
                                setState(() {});
                              },
                            ),
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                        color: Colors.black,
                        onPressed: () async {
                          if (isPlaying) {
                            await audioPlayer.pause();
                          } else {
                            await audioPlayer.resume();
                          }
                        },
                      ),
                    )
                  ]),
                ),
              ),
              Positioned(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.network(
                    apiUrl + widget.categoria.imagen_categoria,
                    width: widthPercentage(.25, context),
                    fit: BoxFit.contain,
                  ),
                ),
              )
            ],
          ));
    }));
  }
}
