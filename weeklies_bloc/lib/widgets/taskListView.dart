import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/widgets/widgets.dart';
import 'package:weeklies/models/models.dart';

/* ListView widget displaying all TaskItems
 * Also creates dialog windows for changing an item's priority or time values
 */
class TaskListView extends StatefulWidget {
  @override
  _TaskListViewState createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  // Displays SimpleDialog with a priority radio set to change a task's priority
  changePriorityWindow(BuildContext priorityContext, Task item) {
    updatePriority(Priority p) {
      Navigator.pop(priorityContext);
      BlocProvider.of<TasksBloc>(priorityContext)
          .add(TaskUpdated(Task(item.timeStamp, item.task, p, item.day)));
    }

    ColorTheme theme =
        (BlocProvider.of<TasksBloc>(context).state as TasksLoadSuccess)
            .theme
            .colorTheme;

    return showDialog(
      barrierColor: theme.accent.withOpacity(0.3),
      context: priorityContext,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: SimpleDialog(
          children: <Widget>[
            Column(
              children: <Widget>[
                CustomPriorityRadio(updatePriority, item.priority),
              ],
            )
          ],
          backgroundColor: theme.accent.withOpacity(0.85),
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
        ),
      ),
    );
  }

  // Displays SimpleDialog with a time radio set to change a task's time
  changeDayWindow(BuildContext dayContext, Task item) {
    updateDay(int day) {
      Navigator.pop(dayContext);
      BlocProvider.of<TasksBloc>(dayContext).add(
          TaskUpdated(Task(item.timeStamp, item.task, item.priority, day)));
    }

    ColorTheme theme =
        (BlocProvider.of<TasksBloc>(context).state as TasksLoadSuccess)
            .theme
            .colorTheme;

    return showDialog(
      barrierColor: theme.accent.withOpacity(0.3),
      context: dayContext,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: SimpleDialog(
          children: <Widget>[
            Column(
              children: <Widget>[
                CustomDayRadio(updateDay, item.day),
              ],
            )
          ],
          backgroundColor: theme.accent.withOpacity(0.85),
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
        ),
      ),
    );
  }

  /* ListView displaying ListTiles with leading priority icon/button followed
   * by the task text and day icon/button
   * Utilizes methods from taskList.dart to manage and remove TaskItems
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO: does this resize actually do anything?
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          if (state is TasksLoadInProgress) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TasksLoadSuccess &&
              state.sort == SortType.priority) {
            List<Task> tasks = state.tasks;
            if (tasks.isNotEmpty) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                      margin: EdgeInsets.fromLTRB(5, 8, 5, 0),
                      decoration: BoxDecoration(
                        color: state.theme.colorTheme.accent,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.only(bottom: 5),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          var taskItem = tasks[index];
                          return getTaskTileDismissible(
                              taskItem, index, state.theme.colorTheme);
                        },
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 5.5,
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          } else if (state is TasksLoadSuccess && state.sort == SortType.day) {
            List<Task> tasks = state.tasks;
            Map<String, dynamic> taskAndIndex = getDaysAndTasks(tasks);

            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: ListView.builder(
                key: Key('day_sort_outer_list_view'),
                itemCount: taskAndIndex.length + 1,
                itemBuilder: (context, index) {
                  // Last item in list is empty container acting as a buffer to allow
                  // TaskItems to sit above bottom button panel when scrollled
                  if (index == taskAndIndex.length) {
                    return Container(
                      height: MediaQuery.of(context).size.height / 6,
                    );
                  } else {
                    return Container(
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 5),
                      margin: EdgeInsets.fromLTRB(5, 8, 5, 0),
                      decoration: BoxDecoration(
                        color: state.theme.colorTheme.accent,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              taskAndIndex.keys.toList()[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(fontSize: 18),
                            ),
                          ),
                          ListView.builder(
                            key: Key('day_sort_inner_list_view'),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                taskAndIndex.values.toList()[index].length,
                            itemBuilder: (context, indexInner) {
                              Task taskItem = taskAndIndex.values
                                  .toList()[index][indexInner][0];
                              int taskIndex = taskAndIndex.values
                                  .toList()[index][indexInner][1];

                              // Task is dismissed on top of gradient
                              return getTaskTileDismissible(
                                  taskItem, taskIndex, state.theme.colorTheme);
                            },
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Dismissible getTaskTileDismissible(
      Task taskItem, int index, ColorTheme theme) {
    //TODO: issue with time change giving task.day is 9??
    //print('TaskItem day : ${taskItem.day}');
    return Dismissible(
      key: GlobalKey(),
      onDismissed: (direction) {
        BlocProvider.of<TasksBloc>(context).add(TaskDeleted(taskItem));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 2.5, 0, 2.5),
        padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
        decoration: BoxDecoration(
          color: taskItem.priority.color(theme),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: ListTile(
          visualDensity: VisualDensity(horizontal: -2),
          // Priority radio button
          leading: GestureDetector(
            onTap: () {
              changePriorityWindow(context, taskItem);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7), shape: BoxShape.circle),
              child: PriorityRadioIcon(taskItem.priority.radio(theme)),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Editable text field for task text
              TaskTextField(taskItem),
              Padding(padding: EdgeInsets.only(top: 4)),
              // Time radio button
              GestureDetector(
                onTap: () {
                  changeDayWindow(context, taskItem);
                },
                child: DayRadioIconTileSize(
                  DayRadio(false,
                      Day(DateTime.now().weekday).dayOptions[taskItem.day]),
                ),
              ),
            ],
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 0),
        ),
      ),
      background: Container(
        margin: EdgeInsets.fromLTRB(0, 2.5, 0, 2.5),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              theme.low,
              theme.lowMed,
              theme.med,
              theme.medHigh,
              theme.high,
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        padding: EdgeInsets.only(left: 20),
      ),
      resizeDuration: Duration(milliseconds: 550),
    );
  }

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
}
