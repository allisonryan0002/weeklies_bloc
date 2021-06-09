import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/widgets/task_text_field.dart';

// class MockTaskBloc extends MockBloc<TasksEvent, TasksState>
//     implements TasksBloc {}

// class FakeTasksEvent extends Fake implements TasksEvent {}

// class FakeTasksState extends Fake implements TasksState {}

void main() {
  Task testerTask = Task(DateTime.now(), 'Test', Priority.low, 1);
  // late TasksBloc tasksBloc;

  // setUpAll(() {
  //   registerFallbackValue<TasksEvent>(FakeTasksEvent());
  //   registerFallbackValue<TasksState>(FakeTasksState());
  // });

  // setUp(() {
  //   tasksBloc = MockTaskBloc();
  // });

  group('TaskTextField', () {
    testWidgets(
      'renders correctly',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TaskTextField(testerTask),
            ),
          ),
        );
        expect(find.byType(TaskTextField), findsOneWidget);
        expect(find.text('Test'), findsOneWidget);
      },
    );

    testWidgets(
      'allows and reflects text editing',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TaskTextField(testerTask),
            ),
          ),
        );
        final textFieldfinder = find.byType(TaskTextField);
        await tester.enterText(textFieldfinder, 'Updated');
        expect(find.text('Updated'), findsOneWidget);
      },
    );

    //TODO: is there a good way to test text editing rather than entering?
    //      like appending something to the existing text
  });
}