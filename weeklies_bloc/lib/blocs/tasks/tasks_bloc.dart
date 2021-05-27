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

  Stream<TasksState> _mapTaskAddedToState(TaskAdded event) async* {
    if (state is TasksLoadSuccess) {
      final List<Task> updatedTasks =
          List.from((state as TasksLoadSuccess).tasks)..add(event.task);
      yield TasksLoadSuccess(updatedTasks);
      _saveTasks(updatedTasks);
    }
  }

  Stream<TasksState> _mapTaskUpdatedToState(TaskUpdated event) async* {
    if (state is TasksLoadSuccess) {
      final List<Task> updatedTasks =
          (state as TasksLoadSuccess).tasks.map((task) {
        return task.key == event.updatedTask.key ? event.updatedTask : task;
      }).toList();
      yield TasksLoadSuccess(updatedTasks);
      _saveTasks(updatedTasks);
    }
  }

  Stream<TasksState> _mapTaskDeletedToState(TaskDeleted event) async* {
    if (state is TasksLoadSuccess) {
      final updatedTasks = (state as TasksLoadSuccess)
          .tasks
          .where((task) => task.key != event.task.key)
          .toList();
      yield TasksLoadSuccess(updatedTasks);
      _saveTasks(updatedTasks);
    }
  }

  Stream<TasksState> _mapPrioritySortedToState() async* {
    if (state is TasksLoadSuccess) {
      List<Task> sortedTasks = prioritySort((state as TasksLoadSuccess).tasks);
      yield TasksLoadSuccess(sortedTasks);
      _saveTasks(sortedTasks);
      _saveSort(SortType.priority);
    }
  }

  Stream<TasksState> _mapTimeSortedToState() async* {
    if (state is TasksLoadSuccess) {
      List<Task> sortedTasks = prioritySort((state as TasksLoadSuccess).tasks);
      sortedTasks.sort((a, b) => a.time.compareTo(b.time));
      yield TasksLoadSuccess(sortedTasks);
      _saveTasks(sortedTasks);
      _saveSort(SortType.time);
    }
  }

  List<Task> prioritySort(List<Task> tasks) {
    tasks.sort((a, b) => a.priority.compareTo(b.priority));
    List<Task> finalSort = [];
    List<Task> intermedSort = [];
    Task prev = tasks[0];
    for (Task item in tasks) {
      if (item.priority == prev.priority) {
        intermedSort.add(item);
      } else {
        if (intermedSort.isNotEmpty) {
          intermedSort.sort((a, b) => a.time.compareTo(b.time));
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
      intermedSort.sort((a, b) => a.time.compareTo(b.time));
      finalSort.addAll(intermedSort);
    }

    return finalSort;
  }

  Future _saveTasks(List<Task> tasks) {
    return tasksRepository.saveTasks(tasks);
  }

  Future _saveSort(SortType sort) {
    return tasksRepository.saveSort(sort);
  }
}
