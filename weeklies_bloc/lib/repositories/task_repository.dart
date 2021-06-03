import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/clients/clients.dart';

class TaskRepository {
  FileClient client;

  TaskRepository({required this.client});

  Future<List<Task>> loadTasks() async {
    final fileContents = await client.read('myTasks.json');
    if (fileContents.isEmpty) return [];
    final jsonContent = JsonDecoder().convert(fileContents);
    return (jsonContent['tasks'])
        .map<Task>((task) => Task.fromJson(task))
        .toList();
  }

  void saveTasks(List<Task> tasks) async {
    final contents = JsonEncoder()
        .convert({'tasks': tasks.map((task) => task.toJson()).toList()});
    client.write('myTasks.json', contents);
  }

  Future<SortType> loadSort() async {
    final fileContents = await client.read('mySort.json');
    if (fileContents.isEmpty) return SortType.priority;

    final jsonContent = JsonDecoder().convert(fileContents);
    return (SortTypeExtension.fromJson(jsonContent['sort']));
  }

  void saveSort(SortType sort) async {
    final contents = JsonEncoder().convert({'sort': sort.toJson()});
    client.write('mySort.json', contents);
  }
}
