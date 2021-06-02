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
  //TODO:
  // late TasksBloc tasksBloc;

  // setUp(() {
  //   tasksBloc = MockTaskBloc();
  // });

  group('PrioritySortButton', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrioritySortButton(),
          ),
        ),
        Duration(seconds: 1),
      );
      expect(
          find.widgetWithIcon(
              PrioritySortButton, Icons.format_list_numbered_rounded),
          findsOneWidget);
    });
  });
}
