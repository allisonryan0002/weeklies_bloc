import 'dart:async';
import 'dart:convert';

import 'package:weeklies/clients/clients.dart';
import 'package:weeklies/models/models.dart';

class TaskRepository {
  TaskRepository({required this.client});

  // [FileClient] provides access to local storage
  FileClient client;

  // Read task file contents & convert from json
  Future<List<Task>> loadTasks() async {
    final fileContents = await client.read('myTasks.json');
    if (fileContents.isEmpty) {
      saveTasks([]);
      return [];
    }
    final jsonContent =
        const JsonDecoder().convert(fileContents) as Map<String, dynamic>;
    final tasksJsonList = jsonContent['tasks']! as List<dynamic>;
    final list = <Task>[];
    for (final taskJson in tasksJsonList) {
      list.add(Task.fromJson(taskJson as Map<String, dynamic>));
    }
    return list;
  }

  // Convert [Task] list to json & write to task file
  // ignore: avoid_void_async
  void saveTasks(List<Task> tasks) async {
    final contents = const JsonEncoder()
        .convert({'tasks': tasks.map((task) => task.toJson()).toList()});
    await client.write('myTasks.json', contents);
  }

  // Read sort file contents & convert from json
  Future<SortType> loadSort() async {
    final fileContents = await client.read('mySort.json');
    if (fileContents.isEmpty) {
      saveSort(SortType.priority);
      return SortType.priority;
    }

    final jsonContent =
        const JsonDecoder().convert(fileContents) as Map<String, dynamic>;
    return SortTypeExtension.fromJson(jsonContent['sort']! as int);
  }

  // Convert [SortType] to json & write to sort file
  // ignore: avoid_void_async
  void saveSort(SortType sort) async {
    final contents = const JsonEncoder().convert({'sort': sort.toJson()});
    await client.write('mySort.json', contents);
  }
}
