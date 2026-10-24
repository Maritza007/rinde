import 'package:flutter/material.dart';

// Colores tomados del prototipo de Rinde (aproximados)
class RindeColors {
  static const verdeOscuro = Color(0xFF1B3D31);
  static const verde = Color(0xFF13694A);
  static const lima = Color(0xFFC6F26B);
  static const fondo = Color(0xFFE6EEE9);
}

// Tema general de la app
ThemeData construirTemaRinde() {
  final esquema = ColorScheme.fromSeed(
    seedColor: RindeColors.verde,
    primary: RindeColors.verde,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: esquema,
    scaffoldBackgroundColor: RindeColors.fondo,
  );
}
