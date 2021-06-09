import 'package:weeklies/models/models.dart';

List<ColorThemeRadio> generateColorThemeRadioList(ColorThemeOption selected) {
  final theme1Radio =
      ColorThemeRadio(false, ColorThemeOption.theme1.colorTheme);
  final theme2Radio =
      ColorThemeRadio(false, ColorThemeOption.theme2.colorTheme);
  final theme3Radio =
      ColorThemeRadio(false, ColorThemeOption.theme3.colorTheme);
  final theme4Radio =
      ColorThemeRadio(false, ColorThemeOption.theme4.colorTheme);
  final theme5Radio =
      ColorThemeRadio(false, ColorThemeOption.theme5.colorTheme);
  switch (selected) {
    case ColorThemeOption.theme1:
      return [
        ColorThemeRadio(true, ColorThemeOption.theme1.colorTheme),
        theme2Radio,
        theme3Radio,
        theme4Radio,
        theme5Radio
      ];

    case ColorThemeOption.theme2:
      return [
        theme1Radio,
        ColorThemeRadio(true, ColorThemeOption.theme2.colorTheme),
        theme3Radio,
        theme4Radio,
        theme5Radio
      ];

    case ColorThemeOption.theme3:
      return [
        theme1Radio,
        theme2Radio,
        ColorThemeRadio(true, ColorThemeOption.theme3.colorTheme),
        theme4Radio,
        theme5Radio
      ];

    case ColorThemeOption.theme4:
      return [
        theme1Radio,
        theme2Radio,
        theme3Radio,
        ColorThemeRadio(true, ColorThemeOption.theme4.colorTheme),
        theme5Radio
      ];

    case ColorThemeOption.theme5:
      return [
        theme1Radio,
        theme2Radio,
        theme3Radio,
        theme4Radio,
        ColorThemeRadio(true, ColorThemeOption.theme5.colorTheme)
      ];
  }
}
