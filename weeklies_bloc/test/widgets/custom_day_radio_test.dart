import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/models/sort.dart';
import 'package:weeklies/widgets/widgets.dart';

// class MockCallback extends Mock implements Function {
//   call(Priority p) {}
// }

//TODO: should the actual Mock be used instead?
class MockCallback {
  int _callCounter = 0;
  void call(int i) {
    _callCounter += 1;
  }

  bool called(int expected) => _callCounter == expected;
  void reset() {
    _callCounter = 0;
  }
}

// class FakeTasksEvent extends Fake implements TasksEvent {}

// class FakeTasksState extends Fake implements TasksState {}

void main() {
  // setUpAll(() {
  //   registerFallbackValue<TasksEvent>(FakeTasksEvent());
  //   registerFallbackValue<TasksState>(FakeTasksState());
  // });
  group('CustomDayRadio', () {
    group('DayRadioIcon', () {
      testWidgets(
        "renders correctly",
        (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: DayRadioIcon(DayRadio(true, 'Today')),
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
        "renders correctly",
        (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: DayRadioIconTileSize(DayRadio(true, 'Today')),
              ),
            ),
          );
          expect(find.byType(DayRadioIconTileSize), findsOneWidget);
          expect(find.text('Today'), findsOneWidget);
        },
      );
    });

    group('CustomDayRadioWidget', () {
      testWidgets("renders correctly", (WidgetTester tester) async {
        final mockedCallback = MockCallback();
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomDayRadio(mockedCallback, 1),
            ),
          ),
        );
        expect(find.byType(CustomDayRadio), findsOneWidget);
        expect(find.byType(DayRadioIcon), findsNWidgets(8));
      });

      testWidgets("callback function is called on tap",
          (WidgetTester tester) async {
        final mockedCallback = MockCallback();
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomDayRadio(mockedCallback, 1),
            ),
          ),
        );
        final radioIconFinder = find.widgetWithText(DayRadioIcon, 'Today');
        await tester.tap(radioIconFinder);
        //verify(() => mockedCallback.call(Priority.high)).called(1);
        expect(mockedCallback.called(1), true);
      });
    });
  });
}
