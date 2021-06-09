import 'package:equatable/equatable.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/utility/adjusted_day.dart';

class Task extends Equatable {
  final DateTime timeStamp;
  final String task;
  final Priority priority;
  final int day;

  Task(this.timeStamp, this.task, this.priority, this.day);

  @override
  List<Object> get props => [timeStamp, task, priority, day];

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
