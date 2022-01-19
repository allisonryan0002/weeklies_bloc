import 'package:equatable/equatable.dart';
import 'package:weeklies/models/models.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class TasksLoaded extends TasksEvent {}

class TaskAdded extends TasksEvent {
  const TaskAdded(this.task);

  final Task task;

  @override
  List<Object> get props => [task];

  @override
  String toString() => 'TaskAdded { Task: $task }';
}

class TaskUpdated extends TasksEvent {
  const TaskUpdated(this.updatedTask);

  final Task updatedTask;

  @override
  List<Object> get props => [updatedTask];

  @override
  String toString() => 'TaskUpdated { Task: $updatedTask }';
}

class TaskDeleted extends TasksEvent {
  const TaskDeleted(this.task);

  final Task task;

  @override
  List<Object> get props => [task];

  @override
  String toString() => 'TaskDeleted { Task: $task }';
}

class PrioritySorted extends TasksEvent {}

class DaySorted extends TasksEvent {}
