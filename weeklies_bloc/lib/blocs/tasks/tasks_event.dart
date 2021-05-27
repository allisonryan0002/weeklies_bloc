import 'package:equatable/equatable.dart';
import 'package:weeklies/models/models.dart';

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

  const TaskUpdated(this.updatedTask);

  @override
  List<Object> get props => [updatedTask];

  @override
  String toString() => 'TaskUpdated { Task: $updatedTask }';
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

class TimeSorted extends TasksEvent {}
