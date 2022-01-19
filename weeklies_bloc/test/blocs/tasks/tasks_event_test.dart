import 'package:flutter_test/flutter_test.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/models/models.dart';

void main() {
  group('TasksEvent', () {
    final task = Task(DateTime(2021, 6), 'Test', Priority.low, 1);

    group('TasksLoaded', () {
      test('toString returns correct value', () {
        expect(
          TasksLoaded().toString(),
          'TasksLoaded()',
        );
      });
    });

    group('TaskAdded', () {
      test('supports value comparisons', () {
        expect(TaskAdded(task), TaskAdded(task));
      });

      test('toString returns correct value', () {
        expect(
          TaskAdded(task).toString(),
          'TaskAdded { Task: $task }',
        );
      });
    });

    group('TaskUpdated', () {
      test('supports value comparisons', () {
        expect(TaskUpdated(task), TaskUpdated(task));
      });

      test('toString returns correct value', () {
        expect(
          TaskUpdated(task).toString(),
          'TaskUpdated { Task: $task }',
        );
      });
    });

    group('TaskDeleted', () {
      test('supports value comparisons', () {
        expect(TaskDeleted(task), TaskDeleted(task));
      });

      test('toString returns correct value', () {
        expect(
          TaskDeleted(task).toString(),
          'TaskDeleted { Task: $task }',
        );
      });
    });

    group('PrioritySorted', () {
      test('toString returns correct value', () {
        expect(
          PrioritySorted().toString(),
          'PrioritySorted()',
        );
      });
    });

    group('DaySorted', () {
      test('toString returns correct value', () {
        expect(
          DaySorted().toString(),
          'DaySorted()',
        );
      });
    });
  });
}
