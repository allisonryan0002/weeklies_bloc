import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sizer/sizer.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/widgets/widgets.dart';

class MockTaskBloc extends MockBloc<TasksEvent, TasksState>
    implements TasksBloc {}

class FakeTasksEvent extends Fake implements TasksEvent {}

class FakeTasksState extends Fake implements TasksState {}

class MockThemeBloc extends MockBloc<ThemeEvent, ThemeState>
    implements ThemeBloc {}

class FakeThemeEvent extends Fake implements ThemeEvent {}

class FakeThemeState extends Fake implements ThemeState {}

void main() {
  late TasksBloc tasksBloc;
  late ThemeBloc themeBloc;

  setUpAll(() {
    registerFallbackValue<TasksEvent>(FakeTasksEvent());
    registerFallbackValue<TasksState>(FakeTasksState());
    registerFallbackValue<ThemeEvent>(FakeThemeEvent());
    registerFallbackValue<ThemeState>(FakeThemeState());
  });

  setUp(() {
    tasksBloc = MockTaskBloc();
    themeBloc = MockThemeBloc();
    when(() => themeBloc.state)
        .thenAnswer((_) => ThemeState(theme: ColorThemeOption.theme1));
  });

  group('TaskInput', () {
    testWidgets(
      'renders correctly',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          Sizer(
            builder: (context, orientation, deviceType) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider<ThemeBloc>.value(value: themeBloc),
                  BlocProvider.value(value: tasksBloc),
                ],
                child: MaterialApp(
                  home: Scaffold(
                    body: TaskInputWidget(),
                  ),
                ),
              );
            },
          ),
        );
        expect(
            find.widgetWithIcon(
                TaskInputWidget, Icons.add_circle_outline_rounded),
            findsOneWidget);
      },
    );

    testWidgets(
      'displays createTaskWindow on tap',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          Sizer(
            builder: (context, orientation, deviceType) {
              return BlocProvider.value(
                value: themeBloc,
                child: MaterialApp(
                  home: Scaffold(
                    body: TaskInputWidget(),
                  ),
                ),
              );
            },
          ),
        );
        final taskInputFinder = find.byType(TaskInputWidget);
        await tester.tap(taskInputFinder);
        await tester.pump();
        expect(find.byType(SimpleDialog), findsOneWidget);
        expect(find.byType(CustomPriorityRadio), findsOneWidget);
        expect(find.byType(CustomDayRadio), findsOneWidget);
        expect(find.byType(TextField), findsOneWidget);
      },
    );

    // TODO: test only passes when timeStamp for task is hardcoded into line 51
    //      of TaskInputWidget file. Maybe make a separate method for testing?
    // testWidgets(
    //   'adds task to list onEditingComplete',
    //   (WidgetTester tester) async {
    //     await tester.pumpWidget(
    //       BlocProvider<TasksBloc>.value(
    //         value: tasksBloc,
    //         child: MaterialApp(
    //           home: Scaffold(
    //             body: TaskInputWidget(),
    //           ),
    //         ),
    //       ),
    //     );
    //     final taskInputFinder = find.byType(TaskInputWidget);
    //     await tester.tap(taskInputFinder);
    //     await tester.pump();
    //     final textFieldFinder = find.byType(TextField);
    //     await tester.enterText(textFieldFinder, 'Test');
    //     await tester.testTextInput.receiveAction(TextInputAction.done);
    //     final task = Task(DateTime(2021, 6, 1), 'Test', Priority.med, 8);
    //     verify(() => tasksBloc.add(TaskAdded(task))).called(1);
    //   },
    // );
  });
}
