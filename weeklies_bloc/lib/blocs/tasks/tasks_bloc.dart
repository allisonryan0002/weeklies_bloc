import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/repository/task_repository.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TaskRepository tasksRepository;

  TasksBloc({required this.tasksRepository}) : super(TasksLoadInProgress());

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
    } else if (event is TimeSorted) {
      yield* _mapTimeSortedToState();
    }
  }

  Stream<TasksState> _mapTasksLoadedToState() async* {
    final tasks = await this.tasksRepository.loadTasks();
    final sort = await this.tasksRepository.loadSort();
    yield TasksLoadSuccess(
      tasks,
      sort,
    );
  }

  //TODO: Sort here
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
        yield TasksLoadSuccess(updatedTasks, SortType.time);
        _saveTasks(updatedTasks);
      }
    }
  }

  //TODO: Sort here
  Stream<TasksState> _mapTaskUpdatedToState(TaskUpdated event) async* {
    if (state is TasksLoadSuccess) {
      if ((state as TasksLoadSuccess).sort == SortType.priority) {
        List<Task> updatedTasks =
            _prioritySort((state as TasksLoadSuccess).tasks.map((task) {
          return task.timeStamp == event.updatedTask.timeStamp
              ? event.updatedTask
              : task;
        }).toList());
        print('Updated tasks: $updatedTasks');
        yield TasksLoadSuccess(updatedTasks, SortType.priority);
        _saveTasks(updatedTasks);
      } else {
        List<Task> updatedTasks =
            _prioritySort((state as TasksLoadSuccess).tasks.map((task) {
          return task.timeStamp == event.updatedTask.timeStamp
              ? event.updatedTask
              : task;
        }).toList());
        print('Updated tasks time: $updatedTasks');
        yield TasksLoadSuccess(updatedTasks, SortType.time);
        _saveTasks(updatedTasks);
      }
    }
  }

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
        yield TasksLoadSuccess(updatedTasks, SortType.time);
        _saveTasks(updatedTasks);
      }
    }
  }

//TODO: Use these map sorted functions in above functions to reduce redundancy?
//      Get rid of timeSort b/c tasks are sorted by time in taskListView?

  Stream<TasksState> _mapPrioritySortedToState() async* {
    if (state is TasksLoadSuccess) {
      List<Task> sortedTasks = _prioritySort((state as TasksLoadSuccess).tasks);
      yield TasksLoadSuccess(sortedTasks, SortType.priority);
      _saveTasks(sortedTasks);
      _saveSort(SortType.priority);
    }
  }

  Stream<TasksState> _mapTimeSortedToState() async* {
    if (state is TasksLoadSuccess) {
      List<Task> sortedTasks = _timeSort((state as TasksLoadSuccess).tasks);
      yield TasksLoadSuccess(sortedTasks, SortType.time);
      _saveSort(SortType.time);
      _saveTasks(sortedTasks);
    }
  }

  List<Task> _prioritySort(List<Task> tasks) {
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

  List<Task> _timeSort(List<Task> tasks) {
    List<Task> sortedTasks = _prioritySort((state as TasksLoadSuccess).tasks);
    sortedTasks.sort((a, b) => a.day.compareTo(b.day));
    return sortedTasks;
  }

  Future _saveTasks(List<Task> tasks) {
    return tasksRepository.saveTasks(tasks);
  }

  Future _saveSort(SortType sort) {
    return tasksRepository.saveSort(sort);
  }
}
