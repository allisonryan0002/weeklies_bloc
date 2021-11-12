import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
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
  final task = Task(DateTime(2021, 6, 1), 'Test', Priority.low, 1);

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

  group('TaskListView', () {
    testWidgets(
      'renders loading indicator when state is TasksLoadInProgress',
      (WidgetTester tester) async {
        when(() => tasksBloc.state).thenAnswer((_) => TasksLoadInProgress());
        await tester.pumpWidget(
          BlocProvider.value(
            value: tasksBloc,
            child: BlocProvider.value(
              value: themeBloc,
              child: MaterialApp(
                home: Scaffold(
                  body: TaskListView(),
                ),
              ),
            ),
          ),
        );
        expect(find.byType(TaskListView), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'renders empty container when state is TasksLoadSuccess with no tasks',
      (WidgetTester tester) async {
        when(() => tasksBloc.state).thenAnswer((_) => TasksLoadSuccess());
        await tester.pumpWidget(
          BlocProvider.value(
            value: tasksBloc,
            child: BlocProvider.value(
              value: themeBloc,
              child: MaterialApp(
                home: Scaffold(
                  body: TaskListView(),
                ),
              ),
            ),
          ),
        );
        expect(find.byType(TaskListView), findsOneWidget);
        expect(find.byType(ListView), findsNothing);
        expect(find.byType(Container), findsOneWidget);
      },
    );

    testWidgets(
      'renders list view when state is TasksLoadSuccess with some tasks',
      (WidgetTester tester) async {
        when(() => tasksBloc.state).thenAnswer((_) => TasksLoadSuccess([task]));
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
                    body: TaskListView(),
                  ),
                ),
              );
            },
          ),
        );
        expect(find.byType(TaskListView), findsOneWidget);
        expect(find.byType(ListView), findsOneWidget);
        expect(find.text('Test'), findsOneWidget);
      },
    );

    testWidgets(
      'renders task tile correctly',
      (WidgetTester tester) async {
        when(() => tasksBloc.state).thenAnswer((_) => TasksLoadSuccess([task]));
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
                    body: TaskListView(),
                  ),
                ),
              );
            },
          ),
        );
        expect(find.widgetWithText(TaskTileTextField, 'Test'), findsOneWidget);
        expect(find.widgetWithText(PriorityRadioIcon, '5'), findsOneWidget);
        expect(
            find.widgetWithText(DayRadioIconTileSize, 'Today'), findsOneWidget);
      },
    );

    //TODO: get this one working
    // testWidgets(
    //   'task tile dismisses',
    //   (WidgetTester tester) async {
    //     when(() => tasksBloc.state).thenAnswer((_) => TasksLoadSuccess([task]));
    //     when(() => tasksBloc.add(TaskDeleted(task)))
    //         .thenAnswer(((_) => TasksLoadSuccess([])));
    //     await tester.pumpWidget(
    //       BlocProvider.value(
    //         value: tasksBloc,
    //         child: MaterialApp(
    //           home: Scaffold(
    //             body: TaskListView(),
    //           ),
    //         ),
    //       ),
    //     );
    //     expect(find.widgetWithText(TaskTextField, 'Test'), findsOneWidget);
    //     expect(find.widgetWithText(PriorityRadioIcon, '5'), findsOneWidget);
    //     expect(
    //         find.widgetWithText(DayRadioIconTileSize, 'Today'), findsOneWidget);
    //     final tileFinder = find.widgetWithText(Dismissible, 'Test');
    //     when(() => tasksBloc.state).thenAnswer((_) => TasksLoadSuccess([]));
    //     await tester.drag(tileFinder, Offset(0, -1000));
    //     await tester.pumpAndSettle();
    //     expect(find.widgetWithText(Dismissible, 'Test'), findsNothing);
    //   },
    // );

    //TODO: get this one and changeDayWindow working...
    // testWidgets(
    //   'renders changePriorityWindow and tile reflects priority change',
    //   (WidgetTester tester) async {
    //     final newTaskToEmit =
    //         Task(task.timeStamp, task.task, Priority.med, task.day);
    //     when(() => tasksBloc.add(TaskUpdated(newTaskToEmit)))
    //         .thenAnswer((_) => TasksLoadSuccess([newTaskToEmit]));
    //     when(() => tasksBloc.state).thenAnswer((_) => TasksLoadSuccess([task]));
    //     await tester.pumpWidget(
    //       Sizer(
    //         builder: (context, orientation, deviceType) {
    //           return MultiBlocProvider(
    //             providers: [
    //               BlocProvider<ThemeBloc>.value(value: themeBloc),
    //               BlocProvider.value(value: tasksBloc),
    //             ],
    //             child: MaterialApp(
    //               home: Scaffold(
    //                 body: TaskListView(),
    //               ),
    //             ),
    //           );
    //         },
    //       ),
    //     );
    //     final priorityFinder = find.widgetWithText(PriorityRadioIcon, '5');
    //     await tester.tap(priorityFinder);
    //     await tester.pump();
    //     expect(find.byType(CustomPriorityRadio), findsOneWidget);
    //     final newPriorityToTapFinder =
    //         find.widgetWithText(PriorityRadioIcon, '3');
    //     await tester.tap(newPriorityToTapFinder);
    //     await tester.pump();
    //     expect(find.widgetWithText(PriorityRadioIcon, '3'), findsOneWidget);
    //   },
    // );

    testWidgets(
      'renders list view sorted in priority format when state is TasksLoadSuccess with SortType.priority',
      (WidgetTester tester) async {
        when(() => tasksBloc.state)
            .thenAnswer((_) => TasksLoadSuccess([task], SortType.priority));
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
                    body: TaskListView(),
                  ),
                ),
              );
            },
          ),
        );
        expect(find.byType(TaskListView), findsOneWidget);
        expect(find.byType(ListView), findsOneWidget);
        expect(find.text('Test'), findsOneWidget);
        expect(find.text('Today'), findsNWidgets(1));
      },
    );

    testWidgets(
      'renders list view sorted in day format when state is TasksLoadSuccess with SortType.day',
      (WidgetTester tester) async {
        when(() => tasksBloc.state)
            .thenAnswer((_) => TasksLoadSuccess([task], SortType.day));
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
                    body: TaskListView(),
                  ),
                ),
              );
            },
          ),
        );
        expect(find.byType(TaskListView), findsOneWidget);
        expect(find.byKey(Key('day_sort_outer_list_view')), findsOneWidget);
        expect(find.byKey(Key('day_sort_inner_list_view')), findsOneWidget);
        expect(find.text('Test'), findsOneWidget);
        expect(find.text('Today'), findsNWidgets(2));
      },
    );
  });
}
