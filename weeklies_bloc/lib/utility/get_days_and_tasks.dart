import 'package:weeklies/models/models.dart';

// Organize [Task]s by [Task.day]
//
// For each [Day], map a list of [Task]s with corresponding [Day]s to it
Map<String, List<dynamic>> getDaysAndTasks(List<Task> tasks) {
  // List with sublist for every [Day] option
  final tasksByDay = [
    <dynamic>[],
    <dynamic>[],
    <dynamic>[],
    <dynamic>[],
    <dynamic>[],
    <dynamic>[],
    <dynamic>[],
    <dynamic>[],
    <dynamic>[],
  ];
  // [Day] options based on the current day of the week
  final dayList = Day(DateTime.now().weekday).dayOptions;
  // List for collecting all non-empty map entries
  final entries = <MapEntry<String, List<dynamic>>>[];

  // Add [Task]s to list position associated with their [Task.day] value
  for (var i = 0; i < tasks.length; i++) {
    final task = tasks[i];
    switch (task.day) {
      case 0:
        tasksByDay[0].add([task, i]);
        break;
      case 1:
        tasksByDay[1].add([task, i]);
        break;
      case 2:
        tasksByDay[2].add([task, i]);
        break;
      case 3:
        tasksByDay[3].add([task, i]);
        break;
      case 4:
        tasksByDay[4].add([task, i]);
        break;
      case 5:
        tasksByDay[5].add([task, i]);
        break;
      case 6:
        tasksByDay[6].add([task, i]);
        break;
      case 7:
        tasksByDay[7].add([task, i]);
        break;
      case 8:
        tasksByDay[8].add([task, i]);
        break;
    }
  }

  // Pair [Day] text with associated [Task]s
  if (tasksByDay[0].isNotEmpty) {
    entries.add(MapEntry<String, List<dynamic>>(dayList[0], tasksByDay[0]));
  }
  if (tasksByDay[1].isNotEmpty) {
    entries.add(MapEntry<String, List<dynamic>>(dayList[1], tasksByDay[1]));
  }
  if (tasksByDay[2].isNotEmpty) {
    entries.add(MapEntry<String, List<dynamic>>(dayList[2], tasksByDay[2]));
  }
  if (tasksByDay[3].isNotEmpty) {
    entries.add(MapEntry<String, List<dynamic>>(dayList[3], tasksByDay[3]));
  }
  if (tasksByDay[4].isNotEmpty) {
    entries.add(MapEntry<String, List<dynamic>>(dayList[4], tasksByDay[4]));
  }
  if (tasksByDay[5].isNotEmpty) {
    entries.add(MapEntry<String, List<dynamic>>(dayList[5], tasksByDay[5]));
  }
  if (tasksByDay[6].isNotEmpty) {
    entries.add(MapEntry<String, List<dynamic>>(dayList[6], tasksByDay[6]));
  }
  if (tasksByDay[7].isNotEmpty) {
    entries.add(MapEntry<String, List<dynamic>>(dayList[7], tasksByDay[7]));
  }
  if (tasksByDay[8].isNotEmpty) {
    entries.add(MapEntry<String, List<dynamic>>(dayList[8], tasksByDay[8]));
  }

  return {}..addEntries(entries);
}
