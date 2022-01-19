import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/repositories/repositories.dart';

class MockThemeRepository extends Mock implements ThemeRepository {}

class MockFile extends Mock implements File {}

void main() {
  group('ThemeBloc', () {
    late ThemeBloc themeBloc;
    late ThemeRepository themeRepository;

    setUp(() {
      themeRepository = MockThemeRepository();
      when(() => themeRepository.saveTheme(ColorThemeOption.theme1))
          .thenAnswer((_) => Future.value(MockFile()));
      themeBloc = ThemeBloc(
        themeRepository: themeRepository,
        initialTheme: ColorThemeOption.theme1,
      );
    });

    blocTest<ThemeBloc, ThemeState>(
      'updates the current theme from the ThemeChanged event',
      build: () => themeBloc,
      act: (ThemeBloc bloc) async =>
          bloc..add(const ThemeChanged(ColorThemeOption.theme2)),
      expect: () => <ThemeState>[
        const ThemeState(theme: ColorThemeOption.theme2),
      ],
    );
  });
}
