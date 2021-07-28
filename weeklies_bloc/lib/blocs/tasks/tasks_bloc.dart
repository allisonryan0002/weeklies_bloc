import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/repositories/repositories.dart';
import 'package:weeklies/utility/utility.dart';

// Manage the state of the [Task]s list and the [SortType]
class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TaskRepository taskRepository;

  TasksBloc({required this.taskRepository}) : super(TasksLoadInProgress());

  @override
  Stream<TasksState> mapEventToState(TasksEvent event) async* {
    if (event is TasksLoaded) {
      yield* _mapTasksLoadedToState();
    } else if (event is TaskAdded) {
      yield* _mapTaskAddedToState(event);
    } else if (event is TaskUpdated) {
      yield* _mapTaskUpdatedToState(event);
    } else if (event is TaskDeleted) {
      yield* _mapTaskDeletedToState(event);
    } else if (event is PrioritySorted) {
      yield* _mapPrioritySortedToState();
    } else if (event is DaySorted) {
      yield* _mapDaySortedToState();
    }
  }

  // Load [SortType] & [Task]s from [TaskRepository]
  Stream<TasksState> _mapTasksLoadedToState() async* {
    final tasks = await this.taskRepository.loadTasks();
    final sort = await this.taskRepository.loadSort();
    yield TasksLoadSuccess(tasks, sort);
  }

  // Add new [Task], resort, & save
  Stream<TasksState> _mapTaskAddedToState(TaskAdded event) async* {
    if (state is TasksLoadSuccess) {
      if ((state as TasksLoadSuccess).sort == SortType.priority) {
        List<Task> updatedTasks = _prioritySort(
            List.from((state as TasksLoadSuccess).tasks)..add(event.task));
        yield TasksLoadSuccess(updatedTasks, SortType.priority);
        _saveTasks(updatedTasks);
      } else {
        List<Task> updatedTasks = _prioritySort(
            List.from((state as TasksLoadSuccess).tasks)..add(event.task));
        yield TasksLoadSuccess(updatedTasks, SortType.day);
        _saveTasks(updatedTasks);
      }
    }
  }

  // Swap existing [Task] for updated [Task] where [Task.timeStamp] matches
  // resort, & save
  Stream<TasksState> _mapTaskUpdatedToState(TaskUpdated event) async* {
    if (state is TasksLoadSuccess) {
      switch (event.taskUpdateType) {
        case TaskUpdateType.text:
          if ((state as TasksLoadSuccess).sort == SortType.priority) {
            List<Task> updatedTasks =
                (state as TasksLoadSuccess).tasks.map((task) {
              return task.timeStamp == event.updatedTask.timeStamp
                  ? event.updatedTask
                  : task;
            }).toList();
            yield TasksLoadSuccess(updatedTasks, SortType.priority);
            _saveTasks(updatedTasks);
          } else {
            List<Task> updatedTasks =
                (state as TasksLoadSuccess).tasks.map((task) {
              return task.timeStamp == event.updatedTask.timeStamp
                  ? event.updatedTask
                  : task;
            }).toList();
            yield TasksLoadSuccess(updatedTasks, SortType.day);
            _saveTasks(updatedTasks);
          }
          break;
        case TaskUpdateType.priority:
        case TaskUpdateType.day:
          if ((state as TasksLoadSuccess).sort == SortType.priority) {
            List<Task> updatedTasks =
                _prioritySort((state as TasksLoadSuccess).tasks.map((task) {
              return task.timeStamp == event.updatedTask.timeStamp
                  ? event.updatedTask
                  : task;
            }).toList());
            yield TasksLoadSuccess(updatedTasks, SortType.priority);
            _saveTasks(updatedTasks);
          } else {
            List<Task> updatedTasks =
                _prioritySort((state as TasksLoadSuccess).tasks.map((task) {
              return task.timeStamp == event.updatedTask.timeStamp
                  ? event.updatedTask
                  : task;
            }).toList());
            yield TasksLoadSuccess(updatedTasks, SortType.day);
            _saveTasks(updatedTasks);
          }
          break;
      }
    }
  }

  // Permanently remove [Task] & save
  Stream<TasksState> _mapTaskDeletedToState(TaskDeleted event) async* {
    if (state is TasksLoadSuccess) {
      if ((state as TasksLoadSuccess).sort == SortType.priority) {
        final List<Task> updatedTasks = (state as TasksLoadSuccess)
            .tasks
            .where((task) => task.timeStamp != event.task.timeStamp)
            .toList();
        yield TasksLoadSuccess(updatedTasks, SortType.priority);
        _saveTasks(updatedTasks);
      } else {
        final List<Task> updatedTasks = (state as TasksLoadSuccess)
            .tasks
            .where((task) => task.timeStamp != event.task.timeStamp)
            .toList();
        yield TasksLoadSuccess(updatedTasks, SortType.day);
        _saveTasks(updatedTasks);
      }
    }
  }

  // Sort [Task]s by [Priority]
  Stream<TasksState> _mapPrioritySortedToState() async* {
    if (state is TasksLoadSuccess) {
      if ((state as TasksLoadSuccess).sort == SortType.day) {
        List<Task> sortedTasks =
            _prioritySort((state as TasksLoadSuccess).tasks);
        yield TasksLoadSuccess(sortedTasks, SortType.priority);
        _saveTasks(sortedTasks);
        _saveSort(SortType.priority);
      }
    }
  }

  // Sort [Task]s by [Day]
  Stream<TasksState> _mapDaySortedToState() async* {
    if (state is TasksLoadSuccess) {
      if ((state as TasksLoadSuccess).sort == SortType.priority) {
        List<Task> sortedTasks = _timeSort((state as TasksLoadSuccess).tasks);
        yield TasksLoadSuccess(sortedTasks, SortType.day);
        _saveSort(SortType.day);
        _saveTasks(sortedTasks);
      }
    }
  }

  // Sort [Task]s by [Priority] then by [Day] within each priority level
  List<Task> _prioritySort(List<Task> tasks) {
    if (tasks.isEmpty) return [];
    tasks.sort((a, b) => a.priority.compareTo(b.priority));
    List<Task> finalSort = [];
    List<Task> intermedSort = [];
    Task prev = tasks[0];
    for (Task item in tasks) {
      if (item.priority == prev.priority) {
        intermedSort.add(item);
      } else {
        if (intermedSort.isNotEmpty) {
          intermedSort.sort((a, b) => a.day.compareTo(b.day));
          finalSort.addAll(intermedSort);
          intermedSort.clear();
          intermedSort.add(item);
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
    List<Task> sortedTasks = _prioritySort((state as TasksLoadSuccess).tasks);
    sortedTasks.sort((a, b) => a.day.compareTo(b.day));
    return sortedTasks;
  }

  void _saveTasks(List<Task> tasks) {
    taskRepository.saveTasks(tasks);
  }

  void _saveSort(SortType sort) {
    taskRepository.saveSort(sort);
  }
}
