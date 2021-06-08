import 'package:flutter_test/flutter_test.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/models/models.dart';

void main() {
  group('TasksState', () {
    group('TasksLoadInProgress', () {
      test('toString returns correct value', () {
        expect(
          TasksLoadInProgress().toString(),
          'TasksLoadInProgress()',
        );
      });
    });

    group('TasksLoadSuccess', () {
      test('toString returns correct value', () {
        expect(
          TasksLoadSuccess(
              [Task(DateTime(2021, 6, 1), 'Test', Priority.low, 1)]).toString(),
          'TasksLoadSuccess { tasks: [${Task(DateTime(2021, 6, 1), 'Test', Priority.low, 1)}] }',
        );
      });
    });
  });
}
