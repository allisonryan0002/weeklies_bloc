import 'package:flutter_test/flutter_test.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/models/models.dart';

void main() {
  group('ThemeState', () {
    test('toString returns correct value', () {
      expect(
        const ThemeState(theme: ColorThemeOption.theme1).toString(),
        'ThemeState { theme: ${ColorThemeOption.theme1} }',
      );
    });
  });
}
