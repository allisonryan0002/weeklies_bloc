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
  final ColorThemeOption theme;

  const TasksLoadSuccess(
      [this.tasks = const [],
      this.sort = SortType.priority,
      this.theme = ColorThemeOption.theme1]);

  @override
  List<Object> get props => [tasks, sort, theme];

  @override
  String toString() => 'TasksLoadSuccess { tasks: $tasks }';
}
