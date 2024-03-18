import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CalculatorThemes {
  static final lightTheme = ThemeData(
    primaryColor: Colors.red,
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontSize: 29),
    ),
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    brightness: debugBrightnessOverride,
    textTheme: const TextTheme(
      titleSmall: TextStyle(fontSize: 20, color: Colors.white),
      titleMedium: TextStyle(fontSize: 29, color: Colors.white),
      headlineLarge: TextStyle(fontSize: 50, color: Colors.white),
    ),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
  );
}
