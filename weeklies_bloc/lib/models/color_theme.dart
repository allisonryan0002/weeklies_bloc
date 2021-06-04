import 'package:flutter/material.dart';

enum ColorThemeOption { theme1, theme2 }

extension ColorThemeOptionExtension on ColorThemeOption {
  ColorTheme get colorTheme {
    switch (this) {
      case ColorThemeOption.theme1:
        return ColorTheme(
          low: Color.fromRGBO(86, 141, 172, 1),
          lowMed: Color.fromRGBO(152, 196, 209, 1),
          med: Color.fromRGBO(254, 203, 93, 1),
          medHigh: Color.fromRGBO(250, 164, 91, 1),
          high: Color.fromRGBO(225, 113, 76, 1),
          accent: Color.fromRGBO(52, 85, 103, 1),
        );
      case ColorThemeOption.theme2:
        return ColorTheme(
          low: Colors.green, //.fromRGBO(86, 141, 172, 1),
          lowMed: Colors.lightGreen, //.fromRGBO(152, 196, 209, 1),
          med: Colors.yellow, //.fromRGBO(254, 203, 93, 1),
          medHigh: Colors.orange, //.fromRGBO(250, 164, 91, 1),
          high: Colors.red, //.fromRGBO(225, 113, 76, 1),
          accent: Colors.blue, //.fromRGBO(52, 85, 103, 1),
        );
    }
  }

  String toJson() {
    switch (this) {
      case ColorThemeOption.theme1:
        return 'theme1';
      case ColorThemeOption.theme2:
        return 'theme2';
    }
  }

  static ColorThemeOption fromJson(String value) {
    switch (value) {
      case 'theme1':
        return ColorThemeOption.theme1;
      case 'theme2':
        return ColorThemeOption.theme2;
      default:
        return throw ArgumentError('Invalid string for a ColorThemeOption');
    }
  }
}

class ColorTheme {
  Color low;
  Color lowMed;
  Color med;
  Color medHigh;
  Color high;
  Color accent;

  ColorTheme(
      {required this.low,
      required this.lowMed,
      required this.med,
      required this.medHigh,
      required this.high,
      required this.accent});
}
