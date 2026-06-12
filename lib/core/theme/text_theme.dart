import 'package:catimage/core/theme/color.dart';
import 'package:flutter/material.dart';

class TextThemeApp {
  TextThemeApp();

  static const String _fontFamily = 'Montserrat';
  final _colors = AppColors();

  String get fontFamily => _fontFamily;

  TextStyle get normal12 =>
      const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: _fontFamily,
      );

  TextStyle get bold60018 =>
      const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: _fontFamily,
      );

  TextStyle get bold60013 =>
      const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        fontFamily: _fontFamily,
      );

  TextStyle get downloadedAtLabel =>
      TextStyle(
        fontSize: 11,
        //color: _colors.mainColor,
        color: _colors.lBlue79B,
        fontWeight: FontWeight.w600,
        fontFamily: _fontFamily,
      );

  TextStyle get historyItemId =>
      const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        fontFamily: _fontFamily,
      );

  TextStyle get errorText => const TextStyle(color: Colors.red);

  TextStyle get badgeText => TextStyle(fontSize: 13, color: _colors.mainColor);
}
