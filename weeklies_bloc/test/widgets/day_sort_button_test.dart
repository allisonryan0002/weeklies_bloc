import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/models/sort.dart';
import 'package:weeklies/widgets/widgets.dart';

class MockTaskBloc extends MockBloc<TasksEvent, TasksState>
    implements TasksBloc {}

void main() {
  late TasksBloc tasksBloc;

  setUp(() {
    tasksBloc = MockTaskBloc();
  });

  group('DaySortButton', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DaySortButton(),
          ),
        ),
        Duration(seconds: 1),
      );
      expect(find.widgetWithIcon(DaySortButton, Icons.access_time_rounded),
          findsOneWidget);
    });

    testWidgets('triggers sorting by day', (WidgetTester tester) async {
      when(() => tasksBloc.state).thenAnswer(
        (_) => TasksLoadSuccess([], SortType.day),
      );
      await tester.pumpWidget(
        BlocProvider<TasksBloc>.value(
          value: tasksBloc,
          child: MaterialApp(
            home: Scaffold(
              body: DaySortButton(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      var daySortButtonFinder =
          find.widgetWithIcon(DaySortButton, Icons.access_time_rounded);
      expect(daySortButtonFinder, findsOneWidget);
      await tester.tap(daySortButtonFinder);
      await tester.pumpAndSettle();
      verify(() => tasksBloc.add(DaySorted())).called(1);
      //TODO: is this test needed? what else should be tested for?
    });
  });
}
