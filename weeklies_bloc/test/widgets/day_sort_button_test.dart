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

  group('DaySortButton', () {
    setUp(() {
      tasksBloc = MockTaskBloc();
      themeBloc = MockThemeBloc();
      when(() => themeBloc.state)
          .thenAnswer((_) => ThemeState(theme: ColorThemeOption.theme1));
    });

    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        Sizer(
          builder: (context, orientation, deviceType) {
            return BlocProvider<ThemeBloc>.value(
              value: themeBloc,
              child: MaterialApp(
                home: Scaffold(
                  body: DaySortButton(),
                ),
              ),
            );
          },
        ),
      );
      expect(find.widgetWithIcon(DaySortButton, Icons.access_time_rounded),
          findsOneWidget);
    });

    testWidgets('triggers sorting by day', (WidgetTester tester) async {
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
                  body: DaySortButton(),
                ),
              ),
            );
          },
        ),
      );
      var daySortButtonFinder =
          find.widgetWithIcon(DaySortButton, Icons.access_time_rounded);
      await tester.tap(daySortButtonFinder);
      verify(() => tasksBloc.add(DaySorted())).called(1);
    });
  });
}
