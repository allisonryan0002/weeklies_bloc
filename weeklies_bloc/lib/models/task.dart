import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:weeklies/models/models.dart';

class Task extends Equatable {
  Key key;
  GlobalKey globalKey;
  String task;
  ItemPriority priority;
  int time;

  Task(this.key, this.globalKey, this.task, this.priority, this.time);

  @override
  List<Object> get props => [globalKey, task, priority, time];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'key': key,
      'task': task,
      'priority': priority.toJson(),
      'time': time,
    };
  }

  static Task fromJson(Map<String, dynamic> json) {
    return Task(
        Key(json['key'].toString()),
        GlobalKey(),
        json['task'] as String,
        ItemPriority.low.fromJson(json["priority"]),
        json["time"] as int);
  }
}
