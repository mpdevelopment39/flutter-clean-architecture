import 'package:flutter/material.dart';

//* Clase con la configuración del tema de la app, colores, fuentes...
class AppTheme {
  //* Theme material
  static ThemeData materialTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFBDFFFF)),
    fontFamily: 'Poppins'
  );

  //* Colors
  static ColorScheme colorScheme = materialTheme.colorScheme;
  static const Color kMoviesWhite = Color(0xFFFFFFFF);
  static const Color kMoviesBlack = Color(0xFF111E21);
  static const Color kMoviesBlackLight = Colors.black26;
  static const Color kMoviesBlackIntermediate = Colors.black54;
  static const Color kMoviesTransparent = Colors.transparent;
  static const Color kMoviesRed = Color(0xFFFF4949);
  static Color kMoviesYellow = Colors.yellow.shade800;

}
