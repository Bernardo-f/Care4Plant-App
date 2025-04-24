import 'package:flutter/material.dart';

import '../helpers/layout_helpers.dart';
import '../../../core/services/l10n/l10n_service.dart';

AlertDialog alertDialog(String content, BuildContext context) {
  return AlertDialog(
    shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.only(topRight: Radius.circular(60), bottomLeft: Radius.circular(60))),
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
              )
            ],
          ),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              alignment: Alignment.center,
              child: Text(
                content,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ))
        ],
      ),
    ),
  );
}

AlertDialog alertDialogGreenhouse(
    String content, BuildContext context, Future<void> Function(bool value) setMessage) {
  return AlertDialog(
    shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.only(topRight: Radius.circular(60), bottomLeft: Radius.circular(60))),
    backgroundColor: const Color.fromRGBO(237, 247, 237, 1),
    content: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              child: Text(
                content,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )),
        ],
      ),
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => const Color.fromRGBO(61, 87, 59, 1)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Ajusta el radio para obtener una forma de "pill"
                ))),
            child: Text(
              L10nService.localizations.closeMessage,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          SizedBox(
            width: widthPercentage(.4, context),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Ajusta el radio para obtener una forma de "pill"
                    side: const BorderSide(
                        color: Color.fromRGBO(61, 87, 50, 1),
                        width: 1.0), // Agrega un borde de color negro con ancho de 2.0
                  )),
              child: Text(
                L10nService.localizations.closeAndNotShowAgain,
                style: const TextStyle(
                    color: Color.fromRGBO(61, 87, 50, 1), fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                setMessage(false);
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      )
    ],
  );
}
