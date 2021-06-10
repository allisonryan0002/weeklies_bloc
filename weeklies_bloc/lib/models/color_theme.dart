import 'package:flutter/material.dart';

// Five custom themes for theming the app
enum ColorThemeOption { theme1, theme2, theme3, theme4, theme5 }

// Class for storing [ColorThemeOption]'s individual [Color]s
class ColorTheme {
  // [Color]s aligning with [Priority] levels
  Color low;
  Color lowMed;
  Color med;
  Color medHigh;
  Color high;

  // Accent [Color] for containers surrounding lists of [TaskTile]s
  Color accent;

  ColorTheme(
      {required this.low,
      required this.lowMed,
      required this.med,
      required this.medHigh,
      required this.high,
      required this.accent});
}

// Convenience extensions
extension ColorThemeOptionExtension on ColorThemeOption {
  // Set [Color]s for each [ColorTheme] corresponding to a [ColorThemeOption]
  ColorTheme get colorTheme {
    switch (this) {
      case ColorThemeOption.theme1:
        return ColorTheme(
          low: Color.fromRGBO(86, 141, 172, 1),
          lowMed: Color.fromRGBO(152, 196, 209, 1),
          med: Color.fromRGBO(254, 203, 93, 1),
          medHigh: Color.fromRGBO(250, 164, 91, 1),
          high: Color.fromRGBO(225, 113, 76, 1),
          accent: Color.fromRGBO(32, 76, 107, 1),
        );
      case ColorThemeOption.theme2:
        return ColorTheme(
          low: Color.fromRGBO(99, 77, 130, 1),
          lowMed: Color.fromRGBO(130, 87, 118, 1),
          med: Color.fromRGBO(209, 120, 119, 1),
          medHigh: Color.fromRGBO(244, 157, 108, 1),
          high: Color.fromRGBO(234, 98, 72, 1),
          accent: Color.fromRGBO(52, 47, 87, 1),
        );
      case ColorThemeOption.theme3:
        return ColorTheme(
          low: Color.fromRGBO(247, 178, 103, 1),
          lowMed: Color.fromRGBO(247, 157, 101, 1),
          med: Color.fromRGBO(244, 132, 95, 1),
          medHigh: Color.fromRGBO(242, 112, 89, 1),
          high: Color.fromRGBO(242, 92, 84, 1),
          accent: Color.fromRGBO(153, 72, 67, 1),
        );
      case ColorThemeOption.theme4:
        return ColorTheme(
          low: Color.fromRGBO(69, 70, 153, 1),
          lowMed: Color.fromRGBO(62, 97, 179, 1),
          med: Color.fromRGBO(89, 138, 210, 1),
          medHigh: Color.fromRGBO(176, 106, 174, 1),
          high: Color.fromRGBO(156, 76, 153, 1),
          accent: Color.fromRGBO(46, 40, 93, 1),
        );
      case ColorThemeOption.theme5:
        return ColorTheme(
          low: Color.fromRGBO(159, 56, 109, 1),
          lowMed: Color.fromRGBO(191, 64, 108, 1),
          med: Color.fromRGBO(214, 104, 102, 1),
          medHigh: Color.fromRGBO(237, 143, 96, 1),
          high: Color.fromRGBO(239, 187, 108, 1),
          accent: Color.fromRGBO(103, 40, 100, 1),
        );
    }
  }

  // Conversion functions to and from json
  String toJson() {
    switch (this) {
      case ColorThemeOption.theme1:
        return 'theme1';
      case ColorThemeOption.theme2:
        return 'theme2';
      case ColorThemeOption.theme3:
        return 'theme3';
      case ColorThemeOption.theme4:
        return 'theme4';
      case ColorThemeOption.theme5:
        return 'theme5';
    }
  }

  static ColorThemeOption fromJson(String value) {
    switch (value) {
      case 'theme1':
        return ColorThemeOption.theme1;
      case 'theme2':
        return ColorThemeOption.theme2;
      case 'theme3':
        return ColorThemeOption.theme3;
      case 'theme4':
        return ColorThemeOption.theme4;
      case 'theme5':
        return ColorThemeOption.theme5;
      default:
        return throw ArgumentError('Invalid string for a ColorThemeOption');
    }
  }
}
