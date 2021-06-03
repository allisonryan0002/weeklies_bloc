import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/repositories/repositories.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

class MockFile extends Mock implements File {}

void main() {
  group('TasksBloc', () {
    late Task task;
    late TasksBloc tasksBloc;
    late TaskRepository tasksRepository;

    setUp(() {
      task = Task(DateTime.utc(2021, 6, 1), 'Test', Priority.low, 1);
      tasksRepository = MockTaskRepository();
      when(() => tasksRepository.loadTasks())
          .thenAnswer((_) => Future.value([]));
      when(() => tasksRepository.loadSort())
          .thenAnswer((_) => Future.value(SortType.priority));
      when(() => tasksRepository.saveTasks([]))
          .thenAnswer((_) => Future.value(MockFile()));
      tasksBloc = TasksBloc(tasksRepository: tasksRepository);
    });

    blocTest(
      'should load tasks from the TasksLoaded event',
      build: () {
        when(() => tasksRepository.loadTasks())
            .thenAnswer((_) => Future.value([task]));
        return tasksBloc;
      },
      act: (TasksBloc bloc) async => bloc..add(TasksLoaded()),
      expect: () => <TasksState>[
        TasksLoadSuccess([task], SortType.priority),
      ],
    );

    blocTest(
      'should add a task to the list from the TaskAdded event',
      build: () => tasksBloc,
      act: (TasksBloc bloc) async =>
          bloc..add(TasksLoaded())..add(TaskAdded(task)),
      expect: () => <TasksState>[
        TasksLoadSuccess([], SortType.priority),
        TasksLoadSuccess([task], SortType.priority),
      ],
    );

    blocTest(
      'should update task from TaskUpdated event',
      build: () => tasksBloc,
      act: (TasksBloc bloc) async => bloc
        ..add(TasksLoaded())
        ..add(TaskAdded(task))
        ..add(TaskUpdated(
            Task(task.timeStamp, 'UpdatedTest', task.priority, task.day))),
      expect: () => <TasksState>[
        TasksLoadSuccess([], SortType.priority),
        TasksLoadSuccess([task], SortType.priority),
        TasksLoadSuccess(
            [Task(task.timeStamp, 'UpdatedTest', task.priority, task.day)],
            SortType.priority),
      ],
    );

    blocTest(
      'should remove task from the list from TaskDeleted event',
      build: () => tasksBloc,
      act: (TasksBloc bloc) async => bloc
        ..add(TasksLoaded())
        ..add(TaskAdded(task))
        ..add(TaskDeleted(task)),
      expect: () => <TasksState>[
        TasksLoadSuccess([], SortType.priority),
        TasksLoadSuccess([task], SortType.priority),
        TasksLoadSuccess([], SortType.priority),
      ],
    );

    blocTest(
      'should set sort to day',
      build: () => tasksBloc,
      act: (TasksBloc bloc) async => bloc..add(TasksLoaded())..add(DaySorted()),
      expect: () => <TasksState>[
        TasksLoadSuccess([], SortType.priority),
        TasksLoadSuccess([], SortType.day),
      ],
    );

    blocTest(
      'should set sort to priority',
      build: () => tasksBloc,
      act: (TasksBloc bloc) async =>
          bloc..add(TasksLoaded())..add(DaySorted())..add(PrioritySorted()),
      expect: () => <TasksState>[
        TasksLoadSuccess([], SortType.priority),
        TasksLoadSuccess([], SortType.day),
        TasksLoadSuccess([], SortType.priority),
      ],
    );
  });
}
