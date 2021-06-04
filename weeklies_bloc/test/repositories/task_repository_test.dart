import 'package:file/file.dart' show File;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weeklies/clients/clients.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/models/task.dart';
import 'package:weeklies/repositories/repositories.dart';

class MockFileClient extends Mock implements FileClient {}

class MockFile extends Mock implements File {}

void main() {
  group('TaskRepository', () {
    late FileClient client;
    late TaskRepository repository;

    setUp(() {
      client = MockFileClient();
      repository = TaskRepository(client: client);
    });

    test(
        'loadTasks method returns empty list of Tasks when no tasks are stored',
        () async {
      when(() => client.read('myTasks.json'))
          .thenAnswer((_) => Future.value(''));
      expect(await repository.loadTasks(), <Task>[]);
    });

    test('loadTasks method returns list of Tasks', () async {
      when(() => client.read('myTasks.json')).thenAnswer((_) => Future.value(
          '{"tasks": [{"timeStamp": "${DateTime.now()}", "task": "Test", "priority": 0, "day": 1}]}'));
      final expectedTask = Task(DateTime.now(), 'Test', Priority.low, 1);
      final actualList = await repository.loadTasks();
      final actualTask = actualList[0];
      expect([actualTask.task, actualTask.priority, actualTask.day],
          [expectedTask.task, expectedTask.priority, expectedTask.day]);
      verify(() => client.read('myTasks.json'));
    });

    test('saveTasks method stores empty task list appropriately in file',
        () async {
      when(() => client.write('myTasks.json', '{"tasks":[]}'))
          .thenAnswer((_) => Future.value(MockFile()));
      repository.saveTasks([]);
      verify(() => client.write('myTasks.json', '{"tasks":[]}')).called(1);
    });

    test('loadSort method returns priority when the file is empty', () async {
      when(() => client.read('mySort.json'))
          .thenAnswer((_) => Future.value(''));
      expect(await repository.loadSort(), SortType.priority);
      verify(() => client.read('mySort.json'));
    });

    test(
        'loadSort method returns SortType.day when SortType.day is in the file',
        () async {
      when(() => client.read('mySort.json'))
          .thenAnswer((_) => Future.value('{"sort": 1}'));
      expect(await repository.loadSort(), SortType.day);
    });

    test('saveSort method stores SortType appropriately in file', () async {
      when(() => client.write('mySort.json', '{"sort":1}'))
          .thenAnswer((_) => Future.value(MockFile()));
      repository.saveSort(SortType.day);
      verify(() => client.write('mySort.json', '{"sort":1}')).called(1);
    });
  });
}
