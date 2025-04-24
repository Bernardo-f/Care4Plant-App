import 'package:care4plant/core/services/l10n/l10n_service.dart';
import 'package:care4plant/env.dart';
import 'package:care4plant/models/accesorio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../provider/plant_provider.dart';
import 'AnimacionesAccesorios/abejas.dart';
import 'AnimacionesAccesorios/pala.dart';
import 'AnimacionesAccesorios/regadera.dart';
import 'AnimacionesAccesorios/sol.dart';

class Plant extends StatelessWidget {
  const Plant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PlantProvider>(context, listen: false).init();
    });
    return Consumer<PlantProvider>(
      builder: (context, provider, _) {
        return Stack(
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 30),
                width: 320,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/img/plant-background.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                child: (provider.plant != null)
                    ? Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(bottom: 70),
                        child: SvgPicture.network(
                          apiUrl + provider.plant!,
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.bottomCenter,
                          width: 300,
                          height: 300,
                        ),
                      )
                    : const SizedBox.shrink()),
            ...buildAnimacion(provider.animacionAccesorio),
            if (provider.accesorios != null) buildAccesorioButtons(context, provider),
          ],
        );
      },
    );
  }

  Widget buildAccesorioButtons(BuildContext context, PlantProvider provider) {
    final accesorios = provider.accesorios!;
    final int page = provider.pageAccesorios;
    final List<Accesorio?> pageAccesorios = List.filled(4, null);
    final endIndex = (accesorios.length <= page * 4) ? accesorios.length : page * 4;

    for (int i = 4 * (page - 1), j = 0; i < endIndex; i++, j++) {
      pageAccesorios[j] = accesorios[i];
    }

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: (pageAccesorios[2] != null && pageAccesorios[3] != null)
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: [
              if (pageAccesorios[2] != null)
                buildButton(pageAccesorios[2]!, provider.playAnimation),
              Row(
                children: [
                  if (page > 1) iconCircle(Icons.remove, provider.previousPage),
                  if (!(accesorios.length <= page * 4)) iconCircle(Icons.add, provider.nextPage),
                ],
              ),
              if (pageAccesorios[3] != null)
                buildButton(pageAccesorios[3]!, provider.playAnimation),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (pageAccesorios[0] != null)
                buildButton(pageAccesorios[0]!, provider.playAnimation),
              if (pageAccesorios[1] != null)
                buildButton(pageAccesorios[1]!, provider.playAnimation),
            ],
          )
        ],
      ),
    );
  }

  Widget iconCircle(IconData icon, VoidCallback onTap) => InkWell(
        onTap: onTap,
        child: Container(
          width: 40,
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(143, 142, 157, 1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white),
        ),
      );
}

List<Widget> buildAnimacion(int i) {
  List<Widget> animacion = [];
  if (i == 1) {
    animacion.add(const Sol());
  }
  if (i == 2) {
    animacion.add(const Pala());
  }
  if (i == 3) {
    animacion.add(const Regadera());
  }
  if (i == 4) {
    animacion.add(const Abeja1());
    animacion.add(const Abeja2());
    animacion.add(const Abeja3());
  }
  return animacion;
}

Widget buildButton(Accesorio accesorio, Function(int) onTap) {
  return InkWell(
    onTap: () {
      if (accesorio.cantidad > 0) {
        onTap(accesorio.id_accesorio);
      }
    },
    child: Stack(clipBehavior: Clip.none, children: [
      Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(143, 142, 157, 1), // Establece el color de fondo deseado
          shape: BoxShape.circle, // Opcional: puedes ajustar la forma del contenedor
        ),
        child: SvgPicture.network(
          apiUrl + accesorio.imagen_accesorio,
          width: 20,
        ),
      ),
      Positioned(
          right: -4,
          bottom: -4,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(61, 87, 50, 1), // Establece el color de fondo deseado
              shape: BoxShape.circle, // Opcional: puedes ajustar la forma del contenedor
            ),
            child: Text(
              accesorio.cantidad.toString(),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ))
    ]),
  );
}

void showMessage(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        L10nService.localizations.minimunStressLevel,
        style: const TextStyle(
            color: Color.fromRGBO(61, 87, 50, 1), fontWeight: FontWeight.bold, fontSize: 17),
      ),
      backgroundColor: const Color.fromRGBO(227, 235, 228, 1),
      duration: const Duration(milliseconds: 2000),
      padding: const EdgeInsets.symmetric(
          horizontal: 8.0, vertical: 10 // Inner padding for SnackBar content.
          ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
