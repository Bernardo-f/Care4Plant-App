// Retorna el ancho de la pantalla según un porcentaje dado
import 'package:flutter/material.dart';

double widthPercentage(double percentage, BuildContext context) {
  return MediaQuery.of(context).size.width * percentage;
}

// Retorna el alto de la pantalla según un porcentaje dado
double heightPercentage(double percentage, BuildContext context) {
  return MediaQuery.of(context).size.height * percentage;
}
