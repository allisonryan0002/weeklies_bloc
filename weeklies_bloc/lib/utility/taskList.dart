// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'dart:io';
// import 'dart:convert';
// import 'package:weeklies/utility/utility.dart';
// import 'package:weeklies/models/models.dart';

// // TaskItems used to store information about tasks
// class TaskItem {
//   Key key;
//   GlobalKey globalKey;
//   String task;
//   ItemPriority priority;
//   int time;

//   TaskItem(this.key, this.globalKey, this.task, this.priority, this.time);
// }

// /* TaskList stores and provides access to the current TaskItems. 
//  * Includes variables and functions for retrieving, maintaining, and updating 
//  * TaskList data.
//  * Data is stored in a single file in JSON. This allows for data persistence as
//  * the app is opened, closed and modified.
//  */
// class TaskList with ChangeNotifier {
//   // File management variables
//   late File jsonFile;
//   late Directory dir;
//   String fileName = "myFile.json";
//   bool fileExists = false;

//   // List of all current TaskItems
//   List<TaskItem> tasks = [];

//   /* Whether the TaskList items should be sorted by their priority or time
//    * Default is priority sort
//    * true implies priority sorting and false implies time sorting
//    */
//   bool prioritySort = true;

//   /* Creates a file in the specified directory for app data storage
//    * Method is only called from newTaskItem & removeTaskItem methods
//    */
//   void createFile(
//       Map<String, dynamic> content, Directory dir, String fileName) {
//     File file = new File(dir.path + "/" + fileName);
//     file.createSync();
//     fileExists = true;
//     file.writeAsStringSync(json.encode(content));
//   }

//   /* Read the file content (if any) and propagate data into a taskList
//    * Method is only called when the app is opened
//    */
//   void readFile(Map<String, dynamic> content) {
//     bool taskExistence = false;
//     if (content.isNotEmpty) {
//       // Get DateTime value from the previous app session
//       List timeVals = content["Time"];
//       DateTime prevTime = DateTime(
//         timeVals[0], // year
//         timeVals[1][0], // month
//         timeVals[1][1], // day
//       );
//       /* Compute time difference between previous and current session (in days)
//        * See dayDifference.dart for function details
//        */
//       int dayDiff = dayDifference(prevTime, DateTime.now());
//       // Add all tasks from the file to the tasks list
//       content.entries.forEach((element) {
//         if (element.key.toString() != "Time" &&
//             element.key.toString() != "PrioritySort") {
//           taskExistence = true;
//           // If the day has changed (i.e. dayDiff != 0), all task times  will
//           // be updated accordingly before being added to the tasks list
//           int taskTime = element.value[2];
//           if (taskTime != 8) {
//             taskTime = taskTime + dayDiff;
//             if (taskTime < 0) {
//               taskTime = 0;
//             }
//           }
//           // Create TaskItem and add to tasks list
//           TaskItem toAdd = new TaskItem(
//               Key(element.key.toString()),
//               GlobalKey(),
//               element.value[0],
//               ItemPriority.low.fromJson(element.value[1]),
//               taskTime);
//           tasks.add(toAdd);
//           // This update to the file content is for any changes to task times
//           content.update(
//               toAdd.key.toString().replaceAll("[<'", '').replaceAll("'>]", ''),
//               (value) => [toAdd.task, toAdd.priority.toJson(), toAdd.time]);
//         }
//       });
//       // Update time of session
//       DateTime now = DateTime.now();
//       content.addEntries([
//         MapEntry<String, dynamic>("Time", [
//           now.year,
//           [
//             now.month,
//             now.day,
//           ]
//         ]),
//       ]);
//       // Sort tasks list in the appropriate order
//       if (taskExistence) {
//         if (content["PrioritySort"]) {
//           priorityTaskItemOrder();
//         } else {
//           timeTaskItemOrder();
//         }
//       }
//     }
//     // Store any changes made to the content during readFile call
//     jsonFile.writeAsStringSync(json.encode(content));
//     notifyListeners();
//   }

//   /* Creates a TaskItem from the given parameters. Adds task to list and file.
//    * Method only called from taskInputWidget
//    */
//   void newTaskItem(String text, ItemPriority priority, int time) {
//     // Create TaskItem, add it to the tasks list and make its map entry
//     TaskItem toAdd =
//         new TaskItem(UniqueKey(), GlobalKey(), text, priority, time);
//     this.tasks.add(toAdd);
//     Map<String, dynamic> content = {
//       toAdd.key.toString(): [toAdd.task, toAdd.priority.toJson(), toAdd.time]
//     };
//     // Add the new task's entry and session time to the existing file contents
//     if (fileExists) {
//       Map<String, dynamic> jsonFileContent = Map();
//       if (jsonFile.readAsStringSync().isNotEmpty) {
//         jsonFileContent = json.decode(jsonFile.readAsStringSync());
//       }
//       jsonFileContent.addAll(content);
//       DateTime now = DateTime.now();
//       content.addEntries([
//         MapEntry<String, dynamic>("Time", [
//           now.year,
//           [
//             now.month,
//             now.day,
//           ]
//         ])
//       ]);
//       jsonFile.writeAsStringSync(json.encode(jsonFileContent));
//       // Combine new task's entry and session time and create file with contents
//     } else {
//       DateTime now = DateTime.now();
//       content.addEntries([
//         MapEntry<String, dynamic>("Time", [
//           now.year,
//           [
//             now.month,
//             now.day,
//           ]
//         ]),
//         MapEntry<String, bool>("PrioritySort", prioritySort)
//       ]);
//       createFile(content, dir, fileName);
//     }
//     // Call appropriate sort method to put new task in its sorted position
//     if (prioritySort) {
//       priorityTaskItemOrder();
//     } else {
//       timeTaskItemOrder();
//     }
//     notifyListeners();
//   }

//   /* Removes a TaskItem from the tasks list and file content
//    * Method only called from taskListView when a ListTile is dismissed
//    */
//   void removeTaskItem(BuildContext context, int index) {
//     TaskItem removed = this.tasks.removeAt(index);
//     Map<String, dynamic> jsonFileContent =
//         json.decode(jsonFile.readAsStringSync());
//     jsonFileContent.remove(
//         removed.key.toString().replaceAll("[<'", '').replaceAll("'>]", ''));
//     jsonFile.deleteSync(recursive: true);
//     // Update time of session
//     DateTime now = DateTime.now();
//     jsonFileContent.addEntries([
//       MapEntry<String, dynamic>("Time", [
//         now.year,
//         [
//           now.month,
//           now.day,
//         ]
//       ])
//     ]);
//     // Recreate the file with the TaskItem removed
//     createFile(jsonFileContent, dir, fileName);
//     notifyListeners();
//   }

//   /* Update changes made to an existing TaskItem in tasks list and file
//    * Responsible for changes made to an item's priority or time values
//    * Method called only from taskListView 
//    */
//   void updateTaskItem(TaskItem oldItem, TaskItem newItem) {
//     // Update file content to reflect changes
//     Map<String, dynamic> jsonFileContent =
//         json.decode(jsonFile.readAsStringSync());
//     jsonFileContent.update(
//         newItem.key.toString().replaceAll("[<'", '').replaceAll("'>]", ''),
//         (value) => [newItem.task, newItem.priority.toJson(), newItem.time]);
//     jsonFile.writeAsStringSync(json.encode(jsonFileContent));
//     // Find index of unchanged item in tasks list and replace with updated item
//     int indexToUpdate = tasks.indexOf(oldItem);
//     tasks[indexToUpdate] = newItem;
//     // Update time of session
//     DateTime now = DateTime.now();
//     jsonFileContent.addEntries([
//       MapEntry<String, dynamic>("Time", [
//         now.year,
//         [
//           now.month,
//           now.day,
//         ]
//       ])
//     ]);
//     // Call appropriate sort method to put changed task in its sorted position
//     if (prioritySort) {
//       priorityTaskItemOrder();
//     } else {
//       timeTaskItemOrder();
//     }
//     notifyListeners();
//   }

//   /* Update a TaskItem's text in tasks list and file
//    * Method only called from taskTextField
//    */
//   void updateTaskItemText(TaskItem item) {
//     Map<String, dynamic> jsonFileContent =
//         json.decode(jsonFile.readAsStringSync());
//     jsonFileContent.update(
//         item.key.toString().replaceAll("[<'", '').replaceAll("'>]", ''),
//         (value) => [item.task, item.priority.toJson(), item.time]);
//     // Update time of session
//     DateTime now = DateTime.now();
//     jsonFileContent.addEntries([
//       MapEntry<String, dynamic>("Time", [
//         now.year,
//         [
//           now.month,
//           now.day,
//         ]
//       ])
//     ]);
//     jsonFile.writeAsStringSync(json.encode(jsonFileContent));
//   }

//   /* Sort tasks list in order of priority values (1-5)
//    * Priority of 1 being at the top and 5 at the bottom
//    * Items with the same priority value are then sorted by their time value
//    * Method called by all methods that modify or create TaskItems
//    */
//   void priorityTaskItemOrder() {
//     // compareTo method defined in itemPriority.dart
//     this.tasks.sort((a, b) => a.priority.compareTo(b.priority));
//     List<TaskItem> finalSort = [];
//     List<TaskItem> intermedSort = [];
//     TaskItem prev = tasks[0];
//     for (TaskItem item in this.tasks) {
//       if (item.priority == prev.priority) {
//         intermedSort.add(item);
//       } else {
//         if (intermedSort.isNotEmpty) {
//           intermedSort.sort((a, b) => a.time.compareTo(b.time));
//           finalSort.addAll(intermedSort);
//           intermedSort.clear();
//           intermedSort.add(item);
//         } else {
//           intermedSort.add(item);
//         }
//       }
//       prev = item;
//     }
//     if (intermedSort.isNotEmpty) {
//       intermedSort.sort((a, b) => a.time.compareTo(b.time));
//       finalSort.addAll(intermedSort);
//     }
//     this.tasks = finalSort;
//     this.prioritySort = true;
//     // Declare prioritySort as on/true in file
//     Map<String, dynamic> jsonFileContent =
//         json.decode(jsonFile.readAsStringSync());
//     jsonFileContent.update("PrioritySort", (dynamic prev) => (true));
//     jsonFile.writeAsStringSync(json.encode(jsonFileContent));
//     notifyListeners();
//   }

//   /* Sort tasks lists in order of time values
//    * Ordered from the most pertinent to the least pertinent
//    * See itemTime.dart for more details on ordering 
//    * Method called by all methods that modify or create TaskItems
//    */
//   void timeTaskItemOrder() {
//     priorityTaskItemOrder();
//     this.tasks.sort((a, b) => a.time.compareTo(b.time));
//     this.prioritySort = false;
//     // Declare prioritySort as off/false in file so time sort is 'on'
//     Map<String, dynamic> jsonFileContent =
//         json.decode(jsonFile.readAsStringSync());
//     jsonFileContent.update("PrioritySort", (dynamic prev) => (false));
//     jsonFile.writeAsStringSync(json.encode(jsonFileContent));
//     notifyListeners();
//   }
// }
