import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/repositories/repositories.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

class MockFile extends Mock implements File {}

void main() {
  group('TasksBloc', () {
    late Task task;
    late TasksBloc tasksBloc;
    late TaskRepository taskRepository;

    setUp(() {
      task = Task(DateTime.utc(2021, 6), 'Test', Priority.low, 1);
      taskRepository = MockTaskRepository();
      when(() => taskRepository.loadTasks())
          .thenAnswer((_) => Future.value([]));
      when(() => taskRepository.loadSort())
          .thenAnswer((_) => Future.value(SortType.priority));
      when(() => taskRepository.saveTasks([]))
          .thenAnswer((_) => Future.value(MockFile()));
      tasksBloc = TasksBloc(taskRepository);
    });

    blocTest<TasksBloc, TasksState>(
      'loads tasks from the TasksLoaded event',
      build: () {
        when(() => taskRepository.loadTasks())
            .thenAnswer((_) => Future.value([task]));
        return tasksBloc;
      },
      act: (TasksBloc bloc) async => bloc..add(TasksLoaded()),
      expect: () => <TasksState>[
        TasksLoadSuccess([task]),
      ],
    );

    blocTest<TasksBloc, TasksState>(
      'adds a task to the list from the TaskAdded event',
      build: () => tasksBloc,
      act: (TasksBloc bloc) async => bloc..add(TaskAdded(task)),
      seed: () => const TasksLoadSuccess(),
      expect: () => <TasksState>[
        TasksLoadSuccess([task]),
      ],
    );

    blocTest<TasksBloc, TasksState>(
      'updates task from TaskUpdated event',
      build: () => tasksBloc,
      act: (TasksBloc bloc) async => bloc
        ..add(
          TaskUpdated(
            Task(task.timeStamp, 'UpdatedTest', task.priority, task.day),
          ),
        ),
      seed: () => TasksLoadSuccess([task]),
      expect: () => <TasksState>[
        TasksLoadSuccess(
          [Task(task.timeStamp, 'UpdatedTest', task.priority, task.day)],
        ),
      ],
    );

    blocTest<TasksBloc, TasksState>(
      'removes task from the list from TaskDeleted event',
      build: () => tasksBloc,
      act: (TasksBloc bloc) async => bloc..add(TaskDeleted(task)),
      seed: () => TasksLoadSuccess([task]),
      expect: () => <TasksState>[
        const TasksLoadSuccess(),
      ],
    );

    blocTest<TasksBloc, TasksState>(
      'sets sort to priority',
      build: () => tasksBloc,
      act: (TasksBloc bloc) async => bloc..add(PrioritySorted()),
      seed: () => const TasksLoadSuccess([], SortType.day),
      expect: () => <TasksState>[
        const TasksLoadSuccess(),
      ],
    );

    blocTest<TasksBloc, TasksState>(
      'sets sort to day',
      build: () => tasksBloc,
      act: (TasksBloc bloc) async => bloc..add(DaySorted()),
      seed: () => const TasksLoadSuccess(),
      expect: () => <TasksState>[
        const TasksLoadSuccess([], SortType.day),
      ],
    );
  });
}
