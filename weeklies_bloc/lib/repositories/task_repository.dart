import 'dart:async';
import 'dart:convert';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/clients/clients.dart';

class TaskRepository {
  // [FileClient] provides access to local storage
  FileClient client;

  TaskRepository({required this.client});

  // Read task file contents & convert from json
  Future<List<Task>> loadTasks() async {
    final fileContents = await client.read('myTasks.json');
    if (fileContents.isEmpty) {
      saveTasks([]);
      return [];
    }
    final jsonContent = JsonDecoder().convert(fileContents);
    return (jsonContent['tasks'])
        .map<Task>((task) => Task.fromJson(task))
        .toList();
  }

  // Convert [Task] list to json & write to task file
  void saveTasks(List<Task> tasks) async {
    final contents = JsonEncoder()
        .convert({'tasks': tasks.map((task) => task.toJson()).toList()});
    client.write('myTasks.json', contents);
  }

  // Read sort file contents & convert from json
  Future<SortType> loadSort() async {
    final fileContents = await client.read('mySort.json');
    if (fileContents.isEmpty) {
      saveSort(SortType.priority);
      return SortType.priority;
    }

    final jsonContent = JsonDecoder().convert(fileContents);
    return (SortTypeExtension.fromJson(jsonContent['sort']));
  }

  // Convert [SortType] to json & write to sort file
  void saveSort(SortType sort) async {
    final contents = JsonEncoder().convert({'sort': sort.toJson()});
    client.write('mySort.json', contents);
  }
}
