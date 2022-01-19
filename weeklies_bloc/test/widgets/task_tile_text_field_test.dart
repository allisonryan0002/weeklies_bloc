import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/widgets/task_tile_text_field.dart';

// class MockTaskBloc extends MockBloc<TasksEvent, TasksState>
//     implements TasksBloc {}

// class FakeTasksEvent extends Fake implements TasksEvent {}

// class FakeTasksState extends Fake implements TasksState {}

void main() {
  final testerTask = Task(DateTime.now(), 'Test', Priority.low, 1);
  // late TasksBloc tasksBloc;

  // setUpAll(() {
  //   registerFallbackValue<TasksEvent>(FakeTasksEvent());
  //   registerFallbackValue<TasksState>(FakeTasksState());
  // });

  // setUp(() {
  //   tasksBloc = MockTaskBloc();
  // });

  group('TaskTileTextField', () {
    testWidgets(
      'renders correctly',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TaskTileTextField(testerTask),
            ),
          ),
        );
        expect(find.byType(TaskTileTextField), findsOneWidget);
        expect(find.text('Test'), findsOneWidget);
      },
    );

    testWidgets(
      'allows and reflects text editing',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TaskTileTextField(testerTask),
            ),
          ),
        );

        final testTextInput = TestTextInput()..register();
        await tester.showKeyboard(find.byType(TaskTileTextField));
        testTextInput.updateEditingValue(const TextEditingValue(text: 'Text'));
        // final textFieldfinder = find.byType(TaskTileTextField);
        // await tester.enterText(textFieldfinder, 'Updated');
        expect(find.text('Text'), findsOneWidget);
      },
    );

    //TODO: is there a good way to test text editing rather than entering?
    //      like appending something to the existing text
  });
}
