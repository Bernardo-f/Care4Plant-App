import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_graphics/vector_graphics.dart';

import '../../helpers/layout_helpers.dart';

Widget pageSetting(String title, String subTittle, Widget widgetSetting, BuildContext context,
    {String? pathImage}) {
  if (pathImage != null) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontFamily: "Rubik",
              color: Color.fromRGBO(58, 60, 62, 1),
              fontSize: 20,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Text(
          subTittle,
          style: const TextStyle(
              fontFamily: "Open Sans", color: Color.fromRGBO(107, 103, 122, 1), fontSize: 19),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          width: 100,
          child: SvgPicture(AssetBytesLoader(pathImage)),
        ),
        widgetSetting
      ],
    );
  } else {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontFamily: "Rubik",
                color: Color.fromRGBO(58, 60, 62, 1),
                fontSize: 20,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: heightPercentage(.05, context)),
            child: Text(
              subTittle,
              style: const TextStyle(
                  fontFamily: "Open Sans", color: Color.fromRGBO(107, 103, 122, 1), fontSize: 19),
              textAlign: TextAlign.center,
            ),
          ),
          widgetSetting
        ],
      ),
    );
  }
}

Text textOption(String text) {
  return Text(text,
      textAlign: TextAlign.start,
      style: const TextStyle(fontFamily: "Rubik", fontWeight: FontWeight.bold));
}
