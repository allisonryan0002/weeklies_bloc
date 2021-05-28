import 'package:equatable/equatable.dart';
import 'package:weeklies/models/models.dart';

class Task extends Equatable {
  final DateTime timeStamp;
  final String task;
  final ItemPriority priority;
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
    return Task(
        DateTime.parse(json['timeStamp'].toString()),
        json['task'] as String,
        ItemPriority.low.fromJson(json["priority"]),
        json["day"] as int);
  }
}
