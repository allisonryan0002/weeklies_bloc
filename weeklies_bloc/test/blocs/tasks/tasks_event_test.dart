import 'package:flutter_test/flutter_test.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/utility/utility.dart';

void main() {
  group('TasksEvent', () {
    group('TasksLoaded', () {
      test('toString returns correct value', () {
        expect(
          TasksLoaded().toString(),
          'TasksLoaded()',
        );
      });
    });

    group('TaskAdded', () {
      test('toString returns correct value', () {
        expect(
          TaskAdded(Task(DateTime(2021, 6, 1), 'Test', Priority.low, 1))
              .toString(),
          'TaskAdded { Task: ${Task(DateTime(2021, 6, 1), 'Test', Priority.low, 1)} }',
        );
      });
    });

    group('TaskUpdated', () {
      test('toString returns correct value', () {
        expect(
          TaskUpdated(Task(DateTime(2021, 6, 1), 'Test', Priority.low, 1),
                  TaskUpdateType.text)
              .toString(),
          'TaskUpdated { Task: ${Task(DateTime(2021, 6, 1), 'Test', Priority.low, 1)} with ${TaskUpdateType.text}}',
        );
      });
    });

    group('TaskDeleted', () {
      test('toString returns correct value', () {
        expect(
          TaskDeleted(Task(DateTime(2021, 6, 1), 'Test', Priority.low, 1))
              .toString(),
          'TaskDeleted { Task: ${Task(DateTime(2021, 6, 1), 'Test', Priority.low, 1)} }',
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
