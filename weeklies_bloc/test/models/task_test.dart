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
      timestamp = DateTime(2021, 6, 1);
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
      expect(Task.fromJson(json), task);
    });

    test('fromJson method throws error for invalid json input', () {
      expect(() => Task.fromJson({}), throwsException);
    });
  });
}
