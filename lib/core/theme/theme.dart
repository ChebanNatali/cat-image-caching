
import 'package:catimage/core/core.dart';
import 'package:catimage/core/theme/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme();

  TextThemeApp get text => TextThemeApp();

  ThemeData themeData(BuildContext context) => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Core.colors.lightBackgroundColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: Core.colors.mainColor,
      secondary: Core.colors.secondary,
      surface: Colors.white,
      surfaceTint: Colors.white,
    ),
    textTheme: Theme.of(context).textTheme.apply(
      bodyColor: Core.colors.textColor,
      displayColor: Core.colors.textColor,
      fontFamily: Core.theme.text.fontFamily,
    ),
  );
}
