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

class Music extends StatefulWidget {
  final Categoria categoria;
  final List<Actividad> actividades;
  final int index;
  const Music({
    Key? key,
    required this.categoria,
    required this.actividades,
    required this.index,
  }) : super(key: key);

  @override
  MusicState createState() => MusicState();
}

class MusicState extends State<Music> with WidgetsBindingObserver {
  late int currentActividad;
  late AddIngresoActividadProvider provider;
  bool isPlaying = false;
  final audioPlayer = AudioPlayer();
  Duration maxDuracion = Duration.zero;
  Duration currentDuration = Duration.zero;
  bool finazalida = false;

  Future<void> initPlayer() async {
    await audioPlayer
        .setSource(UrlSource(apiUrl + widget.actividades[currentActividad].contenido_actividad));
    await audioPlayer.pause();
  }

  @override
  void initState() {
    super.initState();
    provider = Provider.of<AddIngresoActividadProvider>(context, listen: false);
    WidgetsBinding.instance
        .addObserver(this); // Importante, para que funcione el didChangeAppLifecycleState
    currentActividad = widget.index;
    WakelockPlus.toggle(enable: true); // Para que la pantalla no se apague
    initPlayer();
    initializeListeners();
  }

  void initializeListeners() async {
    audioPlayer.onPlayerStateChanged.listen((state) async {
      if (state == PlayerState.paused || state == PlayerState.playing) {
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
      }
      if (state == PlayerState.completed) {
        if (finazalida == false) {
          finazalida = true;
          await provider.addIngresoActividad(widget.actividades[widget.index].id_actividad, true);
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

  void handleNoFinalizada() async {
    await provider.addIngresoActividad(widget.actividades[widget.index].id_actividad, false);
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    if (finazalida == false) {
      handleNoFinalizada();
    }
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
        bottomNavigationBar: Container(
          color: const Color.fromRGBO(193, 202, 195, 1),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(93, 121, 100, 1),
                borderRadius: BorderRadius.vertical(top: Radius.circular(50))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (currentActividad > 0)
                    ? IconButton(
                        icon: const Icon(
                          Icons.skip_previous_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                        color: Colors.black,
                        onPressed: () {
                          setState(() {
                            currentActividad -= 1;
                            isPlaying = false;
                            currentDuration = Duration.zero;
                            finazalida = false;
                            audioPlayer.state = PlayerState.paused;
                            initPlayer();
                            initializeListeners();
                          });
                        },
                      )
                    : const SizedBox(
                        width: 50,
                      ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(255, 255, 255, 0.4),
                  ),
                  child: IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                    color: Colors.black,
                    onPressed: () async {
                      if (isPlaying) {
                        await audioPlayer.pause();
                      } else {
                        await audioPlayer.resume();
                      }
                    },
                  ),
                ),
                (currentActividad != widget.actividades.length - 1)
                    ? IconButton(
                        icon: const Icon(
                          Icons.skip_next_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                        color: Colors.black,
                        onPressed: () {
                          setState(() {
                            currentDuration = Duration.zero;
                            isPlaying = false;
                            finazalida = false;
                            currentActividad += 1;
                            audioPlayer.state = PlayerState.paused;
                            initPlayer();
                            initializeListeners();
                          });
                        },
                      )
                    : const SizedBox(
                        width: 50,
                      ),
              ],
            ),
          ),
        ),
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
          title: Text(
            widget.categoria.nombre_categoria,
            style: const TextStyle(
                fontSize: 20, color: Color.fromRGBO(58, 60, 62, 1), fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color.fromRGBO(193, 202, 195, 1),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 40, left: 20),
                  child: Text(
                    widget.actividades[currentActividad].nombre_actividad,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 10, left: 20),
                  child: Text(
                    widget.actividades[currentActividad].descripcion_actividad,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Color.fromRGBO(110, 112, 115, 1)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(254, 255, 254, .5),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: SvgPicture.network(
                    apiUrl + widget.actividades[currentActividad].imagen_actividad,
                    width: widthPercentage(.01, context),
                    height: heightPercentage(.25, context),
                  ),
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
                          inactiveColor: const Color.fromRGBO(181, 192, 183, 1),
                          value: currentDuration.inSeconds.toDouble(),
                          min: 0,
                          max: maxDuracion.inSeconds.toDouble(),
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      )),
                )
              ],
            )),
      );
    }));
  }
}
