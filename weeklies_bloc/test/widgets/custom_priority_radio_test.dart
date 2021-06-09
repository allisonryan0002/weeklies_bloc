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
  group('CustomPriorityRadio', () {
    late ThemeBloc themeBloc;

    setUpAll(() {
      registerFallbackValue(FakeThemeEvent());
      registerFallbackValue(FakeThemeState());
    });

    setUp(() {
      themeBloc = MockThemeBloc();
      when(() => themeBloc.state).thenAnswer(
        (_) => ThemeState(theme: ColorThemeOption.theme1),
      );
    });

    group('PriorityRadioIcon', () {
      testWidgets(
        "renders correctly",
        (WidgetTester tester) async {
          await tester.pumpWidget(
            BlocProvider.value(
              value: themeBloc,
              child: MaterialApp(
                home: Scaffold(
                  body: PriorityRadioIcon(Priority.low.radio),
                ),
              ),
            ),
          );
          expect(find.byType(PriorityRadioIcon), findsOneWidget);
          expect(find.text('5'), findsOneWidget);
        },
      );
    });

    group('CustomPriorityRadioWidget', () {
      testWidgets("renders correctly", (WidgetTester tester) async {
        await tester.pumpWidget(
          BlocProvider<ThemeBloc>.value(
            value: themeBloc,
            child: MaterialApp(
              home: Scaffold(
                body: CustomPriorityRadio(
                  (_) {},
                  Priority.med,
                ),
              ),
            ),
          ),
        );
        expect(find.byType(CustomPriorityRadio), findsOneWidget);
        expect(find.byType(PriorityRadioIcon), findsNWidgets(5));
      });

      testWidgets("callback function is called on tap",
          (WidgetTester tester) async {
        bool called = false;
        await tester.pumpWidget(
          BlocProvider.value(
              value: themeBloc,
              child: MaterialApp(
                home: Scaffold(
                  body: CustomPriorityRadio(
                    (_) {
                      called = true;
                    },
                    Priority.med,
                  ),
                ),
              )),
        );
        final radioIconFinder = find.widgetWithText(PriorityRadioIcon, '2');
        await tester.tap(radioIconFinder);
        expect(called, true);
      });
    });
  });
}
