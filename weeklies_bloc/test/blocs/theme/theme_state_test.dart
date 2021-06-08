import 'package:flutter_test/flutter_test.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/models/models.dart';

void main() {
  group('ThemeState', () {
    group('ThemeLoadInProgress', () {
      test('toString returns correct value', () {
        expect(
          ThemeLoadInProgress().toString(),
          'ThemeLoadInProgress()',
        );
      });
    });

    group('ThemeLoadSuccess', () {
      test('toString returns correct value', () {
        expect(
          ThemeLoadSuccess(theme: ColorThemeOption.theme1).toString(),
          'ThemeLoadSuccess { theme: ${ColorThemeOption.theme1} }',
        );
      });
    });
  });
}
