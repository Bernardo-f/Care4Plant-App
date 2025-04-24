import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

Widget filledButton(String? text, Color textColor, Color fillColor, double padding,
    BuildContext context, Widget widget, Color? borderColor) {
  return TextButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
      },
      style: TextButton.styleFrom(
          backgroundColor: fillColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: borderColor ?? primaryColor, width: 1.0)),
          padding: EdgeInsets.symmetric(horizontal: padding)),
      child: Text(
        (text != null) ? text : "",
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ));
}
