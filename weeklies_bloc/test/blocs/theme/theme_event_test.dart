import 'package:flutter_test/flutter_test.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/models/models.dart';

void main() {
  group('ThemeEvent', () {
    group('ThemeChanged', () {
      test('toString returns correct value', () {
        expect(
          ThemeChanged(ColorThemeOption.theme2).toString(),
          'ThemeChanged { Theme: ${ColorThemeOption.theme2} }',
        );
      });
    });
  });
}
