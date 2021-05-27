import 'package:equatable/equatable.dart';
import 'package:weeklies/models/models.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

class TasksLoadInProgress extends TasksState {}

class TasksLoadSuccess extends TasksState {
  final List<Task> tasks;
  final SortType sort;

  const TasksLoadSuccess(
      [this.tasks = const [], this.sort = SortType.priority]);

  @override
  List<Object> get props => [tasks, sort];

  @override
  String toString() => 'TasksLoadSuccess { tasks: $tasks }';
}
