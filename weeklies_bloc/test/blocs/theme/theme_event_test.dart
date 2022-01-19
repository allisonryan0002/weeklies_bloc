// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/models/models.dart';

void main() {
  group('ThemeEvent', () {
    group('ThemeChanged', () {
      test('supports value comparisons', () {
        const theme = ColorThemeOption.theme1;
        expect(ThemeChanged(theme), ThemeChanged(theme));
      });

      test('toString returns correct value', () {
        expect(
          const ThemeChanged(ColorThemeOption.theme2).toString(),
          'ThemeChanged { Theme: ${ColorThemeOption.theme2} }',
        );
      });
    });
  });
}
