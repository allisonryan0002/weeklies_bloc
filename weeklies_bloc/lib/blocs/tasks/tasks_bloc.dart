import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/repositories/repositories.dart';

// Manage the state of the [Task]s list and the [SortType]
class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc(this._taskRepository) : super(TasksLoadInProgress()) {
    on(_onTasksLoaded);
    on(_onTaskAdded);
    on(_onTaskUpdated);
    on(_onTaskDeleted);
    on(_onPrioritySorted);
    on(_onDaySorted);
  }

  final TaskRepository _taskRepository;

  // Load [SortType] & [Task]s from [TaskRepository]
  Future<void> _onTasksLoaded(
    TasksLoaded event,
    Emitter<TasksState> emit,
  ) async {
    final tasks = await _taskRepository.loadTasks();
    final sort = await _taskRepository.loadSort();
    emit(TasksLoadSuccess(tasks, sort));
  }

  // Add new [Task], resort, & save
  Future<void> _onTaskAdded(
    TaskAdded event,
    Emitter<TasksState> emit,
  ) async {
    if (state is TasksLoadSuccess) {
      if ((state as TasksLoadSuccess).sort == SortType.priority) {
        final updatedTasks = _prioritySort(
          List.from((state as TasksLoadSuccess).tasks)..add(event.task),
        );
        emit(TasksLoadSuccess(updatedTasks));
        _saveTasks(updatedTasks);
      } else {
        final updatedTasks = _prioritySort(
          List.from((state as TasksLoadSuccess).tasks)..add(event.task),
        );
        emit(TasksLoadSuccess(updatedTasks, SortType.day));
        _saveTasks(updatedTasks);
      }
    }
  }

  // Swap existing [Task] for updated [Task] where [Task.timeStamp] matches
  // resort, & save
  Future<void> _onTaskUpdated(
    TaskUpdated event,
    Emitter<TasksState> emit,
  ) async {
    if (state is TasksLoadSuccess) {
      if ((state as TasksLoadSuccess).sort == SortType.priority) {
        final updatedTasks = _prioritySort(
          (state as TasksLoadSuccess).tasks.map((task) {
            return task.timeStamp == event.updatedTask.timeStamp
                ? event.updatedTask
                : task;
          }).toList(),
        );
        emit(TasksLoadSuccess(updatedTasks));
        _saveTasks(updatedTasks);
      } else {
        final updatedTasks = _prioritySort(
          (state as TasksLoadSuccess).tasks.map((task) {
            return task.timeStamp == event.updatedTask.timeStamp
                ? event.updatedTask
                : task;
          }).toList(),
        );
        emit(TasksLoadSuccess(updatedTasks, SortType.day));
        _saveTasks(updatedTasks);
      }
    }
  }

  // Permanently remove [Task] & save
  Future<void> _onTaskDeleted(
    TaskDeleted event,
    Emitter<TasksState> emit,
  ) async {
    if (state is TasksLoadSuccess) {
      if ((state as TasksLoadSuccess).sort == SortType.priority) {
        final updatedTasks = (state as TasksLoadSuccess)
            .tasks
            .where((task) => task.timeStamp != event.task.timeStamp)
            .toList();
        emit(TasksLoadSuccess(updatedTasks));
        _saveTasks(updatedTasks);
      } else {
        final updatedTasks = (state as TasksLoadSuccess)
            .tasks
            .where((task) => task.timeStamp != event.task.timeStamp)
            .toList();
        emit(TasksLoadSuccess(updatedTasks, SortType.day));
        _saveTasks(updatedTasks);
      }
    }
  }

  // Sort [Task]s by [Priority]
  Future<void> _onPrioritySorted(
    PrioritySorted event,
    Emitter<TasksState> emit,
  ) async {
    if (state is TasksLoadSuccess) {
      if ((state as TasksLoadSuccess).sort == SortType.day) {
        final sortedTasks = _prioritySort((state as TasksLoadSuccess).tasks);
        emit(TasksLoadSuccess(sortedTasks));
        _saveTasks(sortedTasks);
        _saveSort(SortType.priority);
      }
    }
  }

  // Sort [Task]s by [Day]
  Future<void> _onDaySorted(
    DaySorted event,
    Emitter<TasksState> emit,
  ) async {
    if (state is TasksLoadSuccess) {
      if ((state as TasksLoadSuccess).sort == SortType.priority) {
        final sortedTasks = _timeSort((state as TasksLoadSuccess).tasks);
        emit(TasksLoadSuccess(sortedTasks, SortType.day));
        _saveSort(SortType.day);
        _saveTasks(sortedTasks);
      }
    }
  }

  // Sort [Task]s by [Priority] then by [Day] within each priority level
  List<Task> _prioritySort(List<Task> tasks) {
    if (tasks.isEmpty) return [];
    tasks.sort((a, b) => a.priority.compareTo(b.priority));
    final finalSort = <Task>[];
    final intermedSort = <Task>[];
    var prev = tasks[0];
    for (final item in tasks) {
      if (item.priority == prev.priority) {
        intermedSort.add(item);
      } else {
        if (intermedSort.isNotEmpty) {
          intermedSort.sort((a, b) => a.day.compareTo(b.day));
          finalSort.addAll(intermedSort);
          intermedSort
            ..clear()
            ..add(item);
        } else {
          intermedSort.add(item);
        }
      }
      prev = item;
    }
    if (intermedSort.isNotEmpty) {
      intermedSort.sort((a, b) => a.day.compareTo(b.day));
      finalSort.addAll(intermedSort);
    }

    return finalSort;
  }

  // Sort [Task]s by [Day] then by [Priority] within each day
  List<Task> _timeSort(List<Task> tasks) {
    return _prioritySort((state as TasksLoadSuccess).tasks)
      ..sort((a, b) => a.day.compareTo(b.day));
  }

  void _saveTasks(List<Task> tasks) {
    _taskRepository.saveTasks(tasks);
  }

  void _saveSort(SortType sort) {
    _taskRepository.saveSort(sort);
  }
}
