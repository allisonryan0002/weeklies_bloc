import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/models/sort.dart';
import 'package:weeklies/widgets/widgets.dart';

class MockCallback extends Mock implements Function {
  call() {}
}

class FakeTasksEvent extends Fake implements TasksEvent {}

class FakeTasksState extends Fake implements TasksState {}

void main() {
  setUpAll(() {
    registerFallbackValue<TasksEvent>(FakeTasksEvent());
    registerFallbackValue<TasksState>(FakeTasksState());
  });
  group('CustomPriorityRadio', () {
    test('filler test for now', () {});
  });
}

// group('PriorityRadioIcon', () {
    //   testWidgets(
    //     "renders correctly",
    //     (WidgetTester tester) async {
    //       await tester.pumpWidget(
    //         MaterialApp(
    //           home: Scaffold(
    //             body: PriorityRadioIcon(Priority.low.radio),
    //           ),
    //         ),
    //       );
    //       expect(find.byType(PriorityRadioIcon), findsOneWidget);
    //       expect(find.text('5'), findsOneWidget);
    //     },
    //   );
    // });

    // group('CustomPriorityRadioWidget', () {
    //   testWidgets("renders correctly", (WidgetTester tester) async {
    //     final mockedCallback = MockCallback();
    //     await tester.pumpWidget(
    //       MaterialApp(
    //         home: Scaffold(
    //           body: CustomPriorityRadio(mockedCallback.call()),
    //         ),
    //       ),
    //     );
    //     expect(find.byType(CustomPriorityRadio), findsOneWidget);
    //   });

    //   testWidgets("callback function is called on tap",
    //       (WidgetTester tester) async {
    //     final mockedCallback = MockCallback();
    //     await tester.pumpWidget(
    //       MaterialApp(
    //         home: Scaffold(
    //           body: CustomPriorityRadio(mockedCallback.call()),
    //         ),
    //       ),
    //     );
    //     final radioFinder = find.byType(CustomPriorityRadio);
    //     await tester.tap(radioFinder);
    //     verify(mockedCallback()).called(1);
    //   });
    // });
