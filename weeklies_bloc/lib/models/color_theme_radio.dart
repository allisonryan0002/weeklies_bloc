import 'package:weeklies/models/models.dart';

// Model for [ColorThemeRadioIcon]
class ColorThemeRadio {
  // Indicates if this [ColorThemeRadio] is the currently selected radio
  bool isSelected;
  // The [ColorTheme] to pull colors from for the [ColorThemeRadioIcon]
  ColorTheme theme;

  ColorThemeRadio(this.isSelected, this.theme);
}
