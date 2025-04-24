import 'package:care4plant/env.dart';
import 'package:care4plant/models/pensamiento.dart';
import 'package:care4plant/ui/provider/cuidadores_greenhouse_provider.dart';
import 'package:care4plant/ui/provider/greenhouse_provider.dart';
import 'package:care4plant/ui/provider/zone_greenhouse_provider.dart';
import 'package:care4plant/ui/views/home/Greenhouse/zone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../../../../core/services/l10n/l10n_service.dart';
import '../../../../injection_container.dart';
import '../../components/alert_dialogs.dart';
import '../../components/circular_primary_indicator.dart';
import '../../helpers/layout_helpers.dart';
import 'widgets/users_greenhouse.dart';

class Greenhouse extends StatefulWidget {
  const Greenhouse({Key? key}) : super(key: key);

  @override
  GreenhouseState createState() => GreenhouseState();
}

class GreenhouseState extends State<Greenhouse> {
  TextEditingController textEditingController = TextEditingController();
  late GreenhouseProvider greenhouseProvider;
  void addPensamiento() async {
    Pensamiento pensamiento = Pensamiento(
        contenido_pensamiento: textEditingController.text, fecha_pensamiento: DateTime.now());
    //bool add = await greenhouseService.add(pensamiento);
    await greenhouseProvider.addPensamiento(pensamiento);
  }

  @override
  void initState() {
    super.initState();
    greenhouseProvider = Provider.of<GreenhouseProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GreenhouseProvider>(builder: (context, provider, child) {
      if (provider.showMessage) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          showDialog(
              context: context,
              builder: ((context) => alertDialogGreenhouse(
                  L10nService.localizations.introMessageGreenhouse, context, provider.setMessage)));
        });
      }
      if (provider.state == GreenhouseProviderState.success) {
        FocusScope.of(context).requestFocus(FocusNode());
        textEditingController.clear();
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          showDialog(
              context: context,
              builder: ((context) => alertDialog(L10nService.localizations.thoughtsSave, context)));
        });
        Future.microtask(() => provider.resetState());
      }
      return Stack(clipBehavior: Clip.none, children: [
        const Positioned(
            left: -200,
            top: -300,
            child: SvgPicture(
              AssetBytesLoader("assets/img/bg_greenhouse.svg.vec"),
              fit: BoxFit.none,
            )),
        Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: widthPercentage(.7, context),
                  child: Text(
                    L10nService.localizations.messageGreenhouse,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(155, 155, 155, 1),
                        fontSize: 18),
                  ),
                ),
                ChangeNotifierProvider(
                  create: (_) => CuidadoresGreenhouseProvider(sl())..init(),
                  child: UsersGreenhouse(
                    acceptLanguage: L10nService.localizations.localeName,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      (provider.plant != null)
                          ? InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => ChangeNotifierProvider(
                                            create: (_) =>
                                                ZoneGreenhouseProvider(sl(), sl(), sl(), sl())
                                                  ..init(null),
                                            child: const Zone()))));
                              },
                              child: SvgPicture.network(
                                apiUrl + provider.plant!,
                                fit: BoxFit.contain,
                                alignment: Alignment.bottomCenter,
                                width: 100,
                                height: 100,
                              ),
                            )
                          : circularPrimaryColorIndicator,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: widthPercentage(1, context) - 170,
                            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5), // Color de la sombra
                                  spreadRadius: 2, // Extensión de la sombra
                                  blurRadius: 5, // Borrosidad de la sombra
                                  offset: const Offset(0, 3), // Desplazamiento de la sombra
                                ),
                              ],
                            ),
                            child: TextFormField(
                                controller: textEditingController,
                                decoration: InputDecoration(
                                    hintText: L10nService.localizations.inputGreenhouse,
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.only(left: 10),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide:
                                            const BorderSide(width: 0, color: Colors.transparent)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                            width: 0, color: Colors.transparent)))),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: const Color.fromRGBO(178, 206, 196, 1),
                                elevation: 5,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(12)))),
                            child: Text(
                              L10nService.localizations.textButtonGreenhouse,
                              style: const TextStyle(
                                  fontFamily: "Open Sans",
                                  color: Color.fromRGBO(52, 60, 57, 1),
                                  fontWeight: FontWeight.w300),
                            ),
                            onPressed: () {
                              addPensamiento();
                            },
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ]);
    });
  }
}
