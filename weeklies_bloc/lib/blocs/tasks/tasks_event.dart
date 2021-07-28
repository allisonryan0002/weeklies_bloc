import 'package:equatable/equatable.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/utility/utility.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class TasksLoaded extends TasksEvent {}

class TaskAdded extends TasksEvent {
  final Task task;

  const TaskAdded(this.task);

  @override
  List<Object> get props => [task];

  @override
  String toString() => 'TaskAdded { Task: $task }';
}

class TaskUpdated extends TasksEvent {
  final Task updatedTask;
  final TaskUpdateType taskUpdateType;

  const TaskUpdated(this.updatedTask, this.taskUpdateType);

  @override
  List<Object> get props => [updatedTask, taskUpdateType];

  @override
  String toString() => 'TaskUpdated { Task: $updatedTask with $taskUpdateType}';
}

class TaskDeleted extends TasksEvent {
  final Task task;

  const TaskDeleted(this.task);

  @override
  List<Object> get props => [task];

  @override
  String toString() => 'TaskDeleted { Task: $task }';
}

class PrioritySorted extends TasksEvent {}

class DaySorted extends TasksEvent {}
