import 'package:equatable/equatable.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/utility/adjusted_day.dart';

// Model to store task data in
class Task extends Equatable {
  // Time of Task creation or last time it loaded from local storage
  final DateTime timeStamp;
  // User's inputted Task text
  final String task;
  // [Priority] level associated with Task
  final Priority priority;
  // [Day] to complete Task by - stored as a relative int (0-9) as the
  // dayOptions change based on the current day - see [Day]
  final int day;

  Task(this.timeStamp, this.task, this.priority, this.day);

  @override
  List<Object> get props => [timeStamp, task, priority, day];

  // Conversion functions to and from json
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'timeStamp': timeStamp.toString(),
      'task': task,
      'priority': priority.toJson(),
      'day': day,
    };
  }

  static Task fromJson(Map<String, dynamic> json) {
    try {
      DateTime prevTimeStamp = DateTime.parse(json['timeStamp'].toString());
      DateTime currTimeStamp = DateTime.now();
      String taskText = json['task'] as String;
      Priority priority = PriorityExtension.fromJson(json["priority"]);
      int day = json["day"] as int;
      day = adjustedDay(prevTimeStamp, currTimeStamp, day);
      return Task(currTimeStamp, taskText, priority, day);
    } catch (e) {
      return throw e;
    }
  }
}
