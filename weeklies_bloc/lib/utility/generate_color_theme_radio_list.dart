import 'package:weeklies/models/models.dart';

// Given the selected [ColorThemeOption], generate [List<ColorThemeRadio>]
// reflecting the radio that is currently selected
List<ColorThemeRadio> generateColorThemeRadioList(ColorThemeOption selected) {
  // Unselected [ColorThemeRadio]s
  final theme1Radio = ColorThemeRadio(
    theme: ColorThemeOption.theme1.colorTheme,
    isSelected: false,
  );
  final theme2Radio = ColorThemeRadio(
    theme: ColorThemeOption.theme2.colorTheme,
    isSelected: false,
  );
  final theme3Radio = ColorThemeRadio(
    theme: ColorThemeOption.theme3.colorTheme,
    isSelected: false,
  );
  final theme4Radio = ColorThemeRadio(
    theme: ColorThemeOption.theme4.colorTheme,
    isSelected: false,
  );
  final theme5Radio = ColorThemeRadio(
    theme: ColorThemeOption.theme5.colorTheme,
    isSelected: false,
  );

  // Return selected [ColorThemeRadio] with other unselected radios
  switch (selected) {
    case ColorThemeOption.theme1:
      return [
        ColorThemeRadio(
          theme: ColorThemeOption.theme1.colorTheme,
          isSelected: true,
        ),
        theme2Radio,
        theme3Radio,
        theme4Radio,
        theme5Radio
      ];

    case ColorThemeOption.theme2:
      return [
        theme1Radio,
        ColorThemeRadio(
          theme: ColorThemeOption.theme2.colorTheme,
          isSelected: true,
        ),
        theme3Radio,
        theme4Radio,
        theme5Radio
      ];

    case ColorThemeOption.theme3:
      return [
        theme1Radio,
        theme2Radio,
        ColorThemeRadio(
          theme: ColorThemeOption.theme3.colorTheme,
          isSelected: true,
        ),
        theme4Radio,
        theme5Radio
      ];

    case ColorThemeOption.theme4:
      return [
        theme1Radio,
        theme2Radio,
        theme3Radio,
        ColorThemeRadio(
          theme: ColorThemeOption.theme4.colorTheme,
          isSelected: true,
        ),
        theme5Radio
      ];

    case ColorThemeOption.theme5:
      return [
        theme1Radio,
        theme2Radio,
        theme3Radio,
        theme4Radio,
        ColorThemeRadio(
          theme: ColorThemeOption.theme5.colorTheme,
          isSelected: true,
        )
      ];
  }
}
