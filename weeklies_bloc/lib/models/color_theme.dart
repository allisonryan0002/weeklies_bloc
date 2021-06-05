import 'package:flutter/material.dart';

enum ColorThemeOption { theme1, theme2, theme3, theme4, theme5 }

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
          low: Color.fromRGBO(42, 134, 159, 1),
          lowMed: Color.fromRGBO(104, 159, 182, 1),
          med: Color.fromRGBO(187, 126, 140, 1),
          medHigh: Color.fromRGBO(212, 181, 184, 1),
          high: Color.fromRGBO(222, 219, 207, 1),
          accent: Color.fromRGBO(12, 89, 107, 1),
        );
      case ColorThemeOption.theme3:
        return ColorTheme(
          // low: Color.fromRGBO(67, 170, 139, 1),
          // lowMed: Color.fromRGBO(144, 190, 109, 1),
          // med: Color.fromRGBO(249, 199, 79, 1),
          // medHigh: Color.fromRGBO(248, 150, 30, 1),
          // high: Color.fromRGBO(243, 114, 44, 1),
          // accent: Color.fromRGBO(62, 98, 82, 1),
          low: Color.fromRGBO(247, 178, 103, 1),
          lowMed: Color.fromRGBO(247, 157, 101, 1),
          med: Color.fromRGBO(244, 132, 95, 1),
          medHigh: Color.fromRGBO(242, 112, 89, 1),
          high: Color.fromRGBO(242, 92, 84, 1),
          accent: Color.fromRGBO(153, 72, 67, 1),
        );
      case ColorThemeOption.theme4:
        return ColorTheme(
          // low: Color.fromRGBO(137, 112, 148, 1),
          // lowMed: Color.fromRGBO(176, 123, 123, 1),
          // med: Color.fromRGBO(227, 165, 135, 1),
          // medHigh: Color.fromRGBO(223, 128, 101, 1),
          // high: Color.fromRGBO(219, 90, 66, 1),
          // accent: Color.fromRGBO(93, 72, 102, 1),
          low: Color.fromRGBO(97, 198, 232, 1),
          lowMed: Color.fromRGBO(99, 172, 255, 1),
          med: Color.fromRGBO(94, 124, 255, 1),
          medHigh: Color.fromRGBO(128, 71, 252, 1),
          high: Color.fromRGBO(125, 48, 201, 1),
          accent: Color.fromRGBO(87, 23, 150, 1),
        );
      case ColorThemeOption.theme5:
        return ColorTheme(
          low: Color.fromRGBO(91, 146, 121, 1),
          lowMed: Color.fromRGBO(167, 170, 121, 1),
          med: Color.fromRGBO(243, 193, 120, 1),
          medHigh: Color.fromRGBO(242, 126, 96, 1),
          high: Color.fromRGBO(237, 85, 85, 1),
          accent: Color.fromRGBO(62, 98, 82, 1),
        );
    }
  }

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
