import 'package:equatable/equatable.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/utility/adjusted_day.dart';

/// Model to store task data in.
class Task extends Equatable {
  const Task(this.timeStamp, this.task, this.priority, this.day);

  /// Time of Task creation or last time it loaded from local storage.
  final DateTime timeStamp;

  /// User's inputted Task text.
  final String task;

  /// [Priority] level associated with Task.
  final Priority priority;

  /// [Day] to complete Task by - stored as a relative int (0-9) as the
  /// dayOptions change based on the current day - see [Day].
  final int day;

  @override
  List<Object> get props => [timeStamp, task, priority, day];

  /// Conversion functions to and from json.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'timeStamp': timeStamp.toString(),
      'task': task,
      'priority': priority.toJson(),
      'day': day,
    };
  }

  // ignore: prefer_constructors_over_static_methods
  static Task fromJson(Map<String, dynamic> json) {
    try {
      final prevTimeStamp = DateTime.parse(json['timeStamp'].toString());
      final currTimeStamp = DateTime.now();
      final taskText = json['task'] as String;
      final priority = PriorityExtension.fromJson(json['priority']);
      final day = adjustedDay(prevTimeStamp, currTimeStamp, json['day'] as int);

      return Task(currTimeStamp, taskText, priority, day);
    } catch (e) {
      rethrow;
    }
  }
}
