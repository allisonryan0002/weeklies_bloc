import 'package:flutter_test/flutter_test.dart';
import 'package:weeklies/models/models.dart';

void main() {
  group('Task', () {
    DateTime timestamp;
    String text;
    Priority priority;
    int day;
    late Task task;
    late Map<String, dynamic> json;

    setUp(() {
      timestamp = DateTime.now();
      text = 'Test';
      priority = Priority.low;
      day = 1;
      task = Task(timestamp, text, priority, day);
      json = <String, dynamic>{
        'timeStamp': timestamp.toString(),
        'task': text,
        'priority': priority.toJson(),
        'day': day,
      };
    });

    test('toJson method produces correctly formatted map', () {
      expect(task.toJson(), json);
    });

    test('fromJson method produces Task from valid json input', () {
      final actual = Task.fromJson(json);
      final now = DateTime.now();
      final difference = now.difference(actual.timeStamp);
      assert(difference.inSeconds <= 0, 'This task is from the future');
      expect(
        [actual.task, actual.priority, actual.day],
        [task.task, task.priority, task.day],
      );
    });

    test('fromJson method throws error for invalid json input', () {
      expect(() => Task.fromJson(<String, dynamic>{}), throwsException);
    });
  });
}
