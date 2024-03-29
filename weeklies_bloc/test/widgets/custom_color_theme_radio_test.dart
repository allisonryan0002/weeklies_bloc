import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/widgets/widgets.dart';

class MockThemeBloc extends MockBloc<ThemeEvent, ThemeState>
    implements ThemeBloc {}

class FakeThemeEvent extends Fake implements ThemeEvent {}

class FakeThemeState extends Fake implements ThemeState {}

void main() {
  group('CustomColorThemeRadio', () {
    late ThemeBloc themeBloc;

    setUpAll(() {
      registerFallbackValue(FakeThemeEvent());
      registerFallbackValue(FakeThemeState());
    });

    setUp(() {
      themeBloc = MockThemeBloc();
      when(() => themeBloc.state).thenAnswer(
        (_) => const ThemeState(theme: ColorThemeOption.theme1),
      );
    });

    group('ColorThemeRadioIcon', () {
      testWidgets(
        'renders correctly',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            BlocProvider.value(
              value: themeBloc,
              child: MaterialApp(
                home: Scaffold(
                  body: ColorThemeRadioIcon(
                    ColorThemeRadio(
                      theme: ColorThemeOption.theme1.colorTheme,
                      isSelected: false,
                    ),
                  ),
                ),
              ),
            ),
          );
          expect(find.byType(ColorThemeRadioIcon), findsOneWidget);
        },
      );
    });

    group('CustomColorThemeRadioWidget', () {
      testWidgets('renders correctly', (WidgetTester tester) async {
        await tester.pumpWidget(
          BlocProvider<ThemeBloc>.value(
            value: themeBloc,
            child: MaterialApp(
              home: Scaffold(
                body: CustomColorThemeRadio((_) {}, ColorThemeOption.theme1),
              ),
            ),
          ),
        );
        expect(find.byType(CustomColorThemeRadio), findsOneWidget);
        expect(find.byType(ColorThemeRadioIcon), findsNWidgets(5));
      });

      testWidgets('callback function is called on tap',
          (WidgetTester tester) async {
        var called = false;
        await tester.pumpWidget(
          BlocProvider.value(
            value: themeBloc,
            child: MaterialApp(
              home: Scaffold(
                body: CustomColorThemeRadio(
                  (_) {
                    called = true;
                  },
                  ColorThemeOption.theme1,
                ),
              ),
            ),
          ),
        );
        final radioIconFinder = find.byType(ColorThemeRadioIcon).last;
        await tester.tap(radioIconFinder);
        expect(called, true);
      });
    });
  });
}
