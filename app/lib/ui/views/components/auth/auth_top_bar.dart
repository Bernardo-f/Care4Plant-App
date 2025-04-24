import 'package:flutter/material.dart';

import '../../helpers/layout_helpers.dart';
import '../../theme/app_colors.dart';
import 'auth_logo.dart';

Widget topBar(BuildContext context) {
  return Center(
    child: Container(
      margin: const EdgeInsets.only(top: 50),
      width: widthPercentage(.8, context),
      child: Column(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              "Care4plant",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: widthPercentage(.07, context),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: logo(widthPercentage(.23, context)),
          ),
        ],
      ),
    ),
  );
}
