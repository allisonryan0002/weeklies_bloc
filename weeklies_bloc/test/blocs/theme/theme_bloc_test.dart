import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/repositories/repositories.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

class MockFile extends Mock implements File {}

void main() {
  group('ThemeBloc', () {
    late ThemeBloc themeBloc;
    late TaskRepository tasksRepository;

    setUp(() {
      tasksRepository = MockTaskRepository();
      when(() => tasksRepository.loadTheme())
          .thenAnswer((_) => Future.value(ColorThemeOption.theme1));
      when(() => tasksRepository.saveTheme(ColorThemeOption.theme1))
          .thenAnswer((_) => Future.value(MockFile()));
      themeBloc = ThemeBloc(tasksRepository: tasksRepository);
    });

    blocTest(
      'should load Theme from the ThemeLoaded event',
      build: () {
        when(() => tasksRepository.loadTheme())
            .thenAnswer((_) => Future.value(ColorThemeOption.theme3));
        return themeBloc;
      },
      act: (ThemeBloc bloc) async => bloc..add(ThemeLoaded()),
      expect: () => <ThemeState>[
        ThemeLoadSuccess(theme: ColorThemeOption.theme3),
      ],
    );

    blocTest(
      'should updated the current theme from the ThemeChanged event',
      build: () => themeBloc,
      act: (ThemeBloc bloc) async =>
          bloc..add(ThemeLoaded())..add(ThemeChanged(ColorThemeOption.theme2)),
      expect: () => <ThemeState>[
        ThemeLoadSuccess(theme: ColorThemeOption.theme1),
        ThemeLoadSuccess(theme: ColorThemeOption.theme2),
      ],
    );
  });
}
