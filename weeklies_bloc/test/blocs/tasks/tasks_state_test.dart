import 'package:flutter_test/flutter_test.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/models/models.dart';

void main() {
  group('TasksState', () {
    final task = Task(DateTime(2021, 6), 'Test', Priority.low, 1);

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
          TasksLoadSuccess([task]).toString(),
          'TasksLoadSuccess { tasks: [$task] }',
        );
      });
    });
  });
}
