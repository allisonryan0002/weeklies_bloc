import 'package:weeklies/models/models.dart';

Map<String, List<dynamic>> getDaysAndTasks(List<Task> tasks) {
  Map<String, List<dynamic>> map = Map();
  List<dynamic> zero = [];
  List<dynamic> one = [];
  List<dynamic> two = [];
  List<dynamic> three = [];
  List<dynamic> four = [];
  List<dynamic> five = [];
  List<dynamic> six = [];
  List<dynamic> seven = [];
  List<dynamic> eight = [];
  for (int i = 0; i < tasks.length; i++) {
    Task task = tasks[i];
    switch (task.day) {
      case 0:
        zero.add([task, i]);
        break;
      case 1:
        one.add([task, i]);
        break;
      case 2:
        two.add([task, i]);
        break;
      case 3:
        three.add([task, i]);
        break;
      case 4:
        four.add([task, i]);
        break;
      case 5:
        five.add([task, i]);
        break;
      case 6:
        six.add([task, i]);
        break;
      case 7:
        seven.add([task, i]);
        break;
      case 8:
        eight.add([task, i]);
        break;
    }
  }

  List<String> dayList = Day(DateTime.now().weekday).dayOptions;
  List<MapEntry<String, List<dynamic>>> entries = [];

  if (zero.isNotEmpty) {
    entries.add(MapEntry<String, List<dynamic>>(dayList[0], zero));
  }
  if (one.isNotEmpty) {
    entries.add(MapEntry<String, List<dynamic>>(dayList[1], one));
  }
  if (two.isNotEmpty) {
    entries.add(MapEntry<String, List<dynamic>>(dayList[2], two));
  }
  if (three.isNotEmpty) {
    entries.add(MapEntry<String, List<dynamic>>(dayList[3], three));
  }
  if (four.isNotEmpty) {
    entries.add(MapEntry<String, List<dynamic>>(dayList[4], four));
  }
  if (five.isNotEmpty) {
    entries.add(MapEntry<String, List<dynamic>>(dayList[5], five));
  }
  if (six.isNotEmpty) {
    entries.add(MapEntry<String, List<dynamic>>(dayList[6], six));
  }
  if (seven.isNotEmpty) {
    entries.add(MapEntry<String, List<dynamic>>(dayList[7], seven));
  }
  if (eight.isNotEmpty) {
    entries.add(MapEntry<String, List<dynamic>>(dayList[8], eight));
  }

  map.addEntries(entries);
  return map;
}
