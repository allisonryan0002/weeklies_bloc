import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/clients/clients.dart';

class TaskRepository {
  FileClient client;

  TaskRepository({required this.client});

  //Can relace all FileClient's w/ client

  Future<List<Task>> loadTasks() async {
    final fileContents = await client.read('myTasks.json');
    final jsonContent = JsonDecoder().convert(fileContents);
    return (jsonContent['tasks'])
        .map<Task>((task) => Task.fromJson(task))
        .toList();
  }

  Future<File> saveTasks(List<Task> tasks) async {
    final contents = JsonEncoder()
        .convert({'tasks': tasks.map((task) => task.toJson()).toList()});
    return client.write('myTasks.json', contents);
  }

  Future<SortType> loadSort() async {
    final fileContents = await client.read('mySort.json');
    final jsonContent = JsonDecoder().convert(fileContents);
    return (SortType.priority.fromJson(jsonContent['sort']));
  }

  Future<File> saveSort(SortType sort) async {
    final contents = JsonEncoder().convert({'sort': sort.toJson()});
    return client.write('mySort.json', contents);
  }
}
