import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

Widget logo(double width) => SvgPicture(
      const AssetBytesLoader('assets/img/Logo.svg.vec'),
      width: width,
    );

Widget logoGoogle() => const SvgPicture(
      AssetBytesLoader("assets/img/google.svg.vec"),
      fit: BoxFit.none,
    );

Widget iconArrow() => const SvgPicture(
      AssetBytesLoader("assets/img/icon_arrow.svg.vec"),
      fit: BoxFit.none,
    );
