import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../../helpers/layout_helpers.dart';
import '../../theme/app_colors.dart';

class PageOnboarding extends StatelessWidget {
  final String path; // Ruta de la imagen
  final String tittle; // Texto principal que se muestra en la pagina
  final String subTittle; // Texto que se muestra abajo del titulo
  final String text; // Texto que va sobre el boton de next
  final double currentPage; //Numero del slider
  const PageOnboarding(this.path, this.tittle, this.subTittle, this.text, this.currentPage,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: SvgPicture(
            AssetBytesLoader(path),
            fit: BoxFit.fitWidth,
            height: heightPercentage(.25, context),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              return Container(
                  margin: const EdgeInsets.only(right: 10),
                  alignment: Alignment.centerRight,
                  height: 9,
                  width: 9,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPage == index ? primaryColor : Colors.black12,
                  ));
            }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .8,
                  child: Text(
                    tittle.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * .03,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .03),
                  width: MediaQuery.of(context).size.width * .8,
                  child: Text(
                    subTittle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * .02,
                        color: const Color.fromRGBO(112, 112, 112, 1)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .05),
                  width: MediaQuery.of(context).size.width * .6,
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * .015,
                        color: const Color.fromRGBO(112, 112, 112, 1)),
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
