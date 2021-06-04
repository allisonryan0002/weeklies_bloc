import 'dart:async';
import 'dart:convert';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/clients/clients.dart';

class TaskRepository {
  FileClient client;

  TaskRepository({required this.client});

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

  void saveTasks(List<Task> tasks) async {
    final contents = JsonEncoder()
        .convert({'tasks': tasks.map((task) => task.toJson()).toList()});
    client.write('myTasks.json', contents);
  }

  Future<SortType> loadSort() async {
    final fileContents = await client.read('mySort.json');
    if (fileContents.isEmpty) {
      saveSort(SortType.priority);
      return SortType.priority;
    }

    final jsonContent = JsonDecoder().convert(fileContents);
    return (SortTypeExtension.fromJson(jsonContent['sort']));
  }

  void saveSort(SortType sort) async {
    final contents = JsonEncoder().convert({'sort': sort.toJson()});
    client.write('mySort.json', contents);
  }

  Future<ColorThemeOption> loadTheme() async {
    final fileContents = await client.read('myTheme.json');
    if (fileContents.isEmpty) {
      saveTheme(ColorThemeOption.theme1);
      return ColorThemeOption.theme1;
    }

    final jsonContent = JsonDecoder().convert(fileContents);
    return (ColorThemeOptionExtension.fromJson(jsonContent['theme']));
  }

  void saveTheme(ColorThemeOption theme) async {
    final contents = JsonEncoder().convert({'theme': theme.toJson()});
    client.write('myTheme.json', contents);
  }
}
