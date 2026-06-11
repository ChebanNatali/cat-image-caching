import 'package:flutter/material.dart';

class TextThemeApp {
  TextThemeApp();
  static const String _fontFamily = 'Montserrat';

  String get fontFamily => _fontFamily;

  TextStyle get normal12 => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  TextStyle get black60018 => const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

}
