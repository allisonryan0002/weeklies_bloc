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
  group('CustomDayRadio', () {
    late ThemeBloc themeBloc;

    setUpAll(() {
      registerFallbackValue(FakeThemeEvent());
      registerFallbackValue(FakeThemeState());
    });

    setUp(() async {
      themeBloc = MockThemeBloc();
      when(() => themeBloc.state).thenAnswer(
        (_) => const ThemeState(theme: ColorThemeOption.theme1),
      );
    });

    group('DayRadioIcon', () {
      testWidgets(
        'renders correctly',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            BlocProvider.value(
              value: themeBloc,
              child: MaterialApp(
                home: Scaffold(
                  body: DayRadioIcon(
                    DayRadio(dayText: 'Today', isSelected: true),
                  ),
                ),
              ),
            ),
          );
          expect(find.byType(DayRadioIcon), findsOneWidget);
          expect(find.text('Today'), findsOneWidget);
        },
      );
    });

    group('DayRadioIconTileSize', () {
      testWidgets(
        'renders correctly',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: DayRadioIconTileSize(
                  DayRadio(dayText: 'Today', isSelected: true),
                ),
              ),
            ),
          );
          expect(find.byType(DayRadioIconTileSize), findsOneWidget);
          expect(find.text('Today'), findsOneWidget);
        },
      );
    });

    group('CustomDayRadioWidget', () {
      testWidgets('renders correctly', (WidgetTester tester) async {
        await tester.pumpWidget(
          BlocProvider.value(
            value: themeBloc,
            child: MaterialApp(
              home: Scaffold(
                body: CustomDayRadio((_) {}, 1),
              ),
            ),
          ),
        );
        expect(find.byType(CustomDayRadio), findsOneWidget);
        expect(find.byType(DayRadioIcon), findsNWidgets(8));
      });

      testWidgets('callback function is called on tap',
          (WidgetTester tester) async {
        var called = false;
        await tester.pumpWidget(
          BlocProvider.value(
            value: themeBloc,
            child: MaterialApp(
              home: Scaffold(
                body: CustomDayRadio(
                  (_) {
                    called = true;
                  },
                  1,
                ),
              ),
            ),
          ),
        );
        final radioIconFinder = find.widgetWithText(DayRadioIcon, 'Today');
        await tester.tap(radioIconFinder);
        expect(called, true);
      });
    });
  });
}
