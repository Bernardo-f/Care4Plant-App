// Retorna el alto de la pantalla según un porcentaje dado
import 'package:flutter/material.dart';

double heightPercentage(double percentage, BuildContext context) {
  return MediaQuery.of(context).size.height * percentage;
}

// Retorna el ancho de la pantalla según un porcentaje dado
double widthPercentage(double percentage, BuildContext context) {
  return MediaQuery.of(context).size.width * percentage;
}
