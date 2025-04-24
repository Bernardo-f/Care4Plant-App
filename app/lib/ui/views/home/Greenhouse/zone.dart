import 'package:intl/intl.dart';
import 'package:care4plant/env.dart';
import 'package:care4plant/models/pensamiento.dart';
import 'package:care4plant/models/user_greenhouse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/l10n/l10n_service.dart';
import '../../../provider/zone_greenhouse_provider.dart';
import '../../components/circular_primary_indicator.dart';

class Zone extends StatefulWidget {
  final UserGreenhouse? userGreenhouse;
  const Zone({Key? key, this.userGreenhouse}) : super(key: key);

  @override
  ZoneState createState() => ZoneState();
}

class ZoneState extends State<Zone> {
  late ZoneGreenhouseProvider zoneGreenhouseProvider;

  final welcomeMessageStyle = const TextStyle(
      color: Color.fromRGBO(61, 87, 50, 1), fontWeight: FontWeight.bold, fontSize: 20);
  @override
  void initState() {
    super.initState();
    zoneGreenhouseProvider = Provider.of<ZoneGreenhouseProvider>(context, listen: false);
  }

  void meGusta(DateTime fechaPensamiento) async {
    await zoneGreenhouseProvider.megustaPensamiento(
        (widget.userGreenhouse == null) ? null : widget.userGreenhouse?.email, fechaPensamiento);
    await zoneGreenhouseProvider
        .refreshPensamientos((widget.userGreenhouse == null) ? null : widget.userGreenhouse?.email);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ZoneGreenhouseProvider>(builder: (context, provider, state) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color.fromRGBO(93, 94, 93, 1),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          toolbarHeight: 50,
          backgroundColor: Colors.transparent,
        ),
        body: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
            width: double.infinity,
            child: (widget.userGreenhouse == null)
                ? (provider.name != null)
                    ? Text(
                        L10nService.localizations.welcomeMessageGreenhouse(provider.name!),
                        style: welcomeMessageStyle,
                        textAlign: TextAlign.center,
                      )
                    : const SizedBox.shrink()
                : Text(
                    L10nService.localizations.welcomeMessageGreenhouse(widget.userGreenhouse!.name),
                    style: welcomeMessageStyle,
                    textAlign: TextAlign.center,
                  ),
          ),
          Expanded(
              child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 30),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(237, 247, 237, 1),
                borderRadius: BorderRadius.only(topRight: Radius.elliptical(90, 90))),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  width: 320,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/img/plant-background.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: (widget.userGreenhouse == null)
                        ? (provider.plant != null)
                            ? Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(bottom: 70),
                                child: SvgPicture.network(
                                  apiUrl + provider.plant!,
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.bottomCenter,
                                  width: 190,
                                  height: 190,
                                ),
                              )
                            : circularPrimaryColorIndicator
                        : Container(
                            margin: const EdgeInsets.only(bottom: 40),
                            child: SvgPicture.network(
                              apiUrl + widget.userGreenhouse!.plant,
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.bottomCenter,
                              width: 190,
                              height: 190,
                            ),
                          ),
                  ),
                ),
                Expanded(
                    child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(topRight: Radius.elliptical(90, 90)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(4, -3),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: (provider.state == ZoneGreenhouseProviderState.loading)
                      ? const Center(child: circularPrimaryColorIndicator)
                      : (provider.state == ZoneGreenhouseProviderState.error)
                          ? const Center(child: Text("Error al cargar los pensamientos"))
                          : buildPensamientos(provider.pensamientos, meGusta),
                ))
              ],
            ),
          ))
        ]),
      );
    });
  }
}

Widget buildPensamientos(List<Pensamiento> pensamientos, Function(DateTime) meGusta) {
  return Scrollbar(
      thumbVisibility: true,
      child: ListView.builder(
          itemCount: pensamientos.length,
          itemBuilder: ((context, index) {
            final pensamiento = pensamientos[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatDate(pensamiento.fecha_pensamiento, AppLocalizations.of(context)!),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color.fromRGBO(107, 103, 122, 1)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Container(
                        margin: const EdgeInsets.only(left: 100),
                        child: Text(
                          pensamiento.contenido_pensamiento,
                          style: const TextStyle(
                              color: Color.fromRGBO(107, 103, 122, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      )),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              meGusta(pensamiento.fecha_pensamiento);
                            },
                            iconSize: 30,
                            visualDensity: VisualDensity.comfortable,
                            padding: EdgeInsets.zero,
                            icon: Icon(
                                (pensamiento.megusta!) ? Icons.favorite : Icons.favorite_border),
                            color: const Color.fromRGBO(255, 139, 156, 1),
                          ),
                          Text(
                            pensamiento.numero_me_gustas.toString(),
                            style: const TextStyle(
                                color: Color.fromRGBO(107, 103, 122, 1),
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            );
          })));
}

String formatDate(DateTime date, AppLocalizations appLocalizations) {
  DateTime today = DateTime.now();

  // Compara si la fecha es igual a la fecha de hoy
  if (date.year == today.year && date.month == today.month && date.day == today.day) {
    // Si la fecha es igual a hoy, agrega la condición para mostrar algo especial
    return appLocalizations.dateToday;
  }
  final DateFormat formatter = DateFormat('dd MMM', appLocalizations.localeName);
  return formatter.format(date);
}
