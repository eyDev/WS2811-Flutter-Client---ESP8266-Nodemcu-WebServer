import 'package:flutter/material.dart';

class Colores {
  static final Colores _instancia = new Colores._();

  factory Colores() {
    return _instancia;
  }

  Colores._();
  int red = 0;
  int green = 0;
  int blue = 255;
  Color pickerColor = Colors.blue;
}
