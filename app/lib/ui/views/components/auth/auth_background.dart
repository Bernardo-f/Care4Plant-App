import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

Widget background() => const SvgPicture(
      AssetBytesLoader('assets/img/background1.svg.vec'),
      fit: BoxFit.none,
    );

BoxDecoration inputBgDecoration() => const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/img/inputs_background.png"),
        fit: BoxFit.contain,
      ),
    );
