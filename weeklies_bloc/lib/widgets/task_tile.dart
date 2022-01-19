import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/widgets/widgets.dart';

class TaskTile extends StatefulWidget {
  const TaskTile(this.taskItem, this.theme, {Key? key}) : super(key: key);

  final Task taskItem;
  final ColorTheme theme;

  @override
  TaskTileState createState() => TaskTileState();
}

class TaskTileState extends State<TaskTile> {
  // Strings that are randomly selected to be displayed when a [TaskTile] is
  // dismissed
  List<String> dismissTextList = [
    'Never again...',
    'YAY 🙌',
    'Productivity +1',
    'Time for a nap... 😴',
    'Wooohooo! 🥳',
    'DONE 👏👏👏',
    'Like it never happened... 👀',
    'Goodbye 👋',
    'Very Good Job 🦄',
  ];
  // For selecting a random string from the dismissTextList
  final rand = Random();

  // [SimpleDialog] with [CustomPriorityRadio] to change [Task]'s [Priority]
  Future<void> changePriorityWindow(
    BuildContext priorityContext,
    Task item,
    ColorTheme theme,
  ) {
    void updatePriority(Priority p) {
      Navigator.pop(priorityContext);
      BlocProvider.of<TasksBloc>(priorityContext)
          .add(TaskUpdated(Task(item.timeStamp, item.task, p, item.day)));
    }

    return showDialog<void>(
      barrierColor: theme.accent.withOpacity(0.3),
      context: priorityContext,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: SimpleDialog(
          backgroundColor: theme.accent.withOpacity(0.85),
          elevation: 1,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          children: [
            Column(
              children: [
                CustomPriorityRadio(updatePriority, item.priority),
              ],
            )
          ],
        ),
      ),
    );
  }

  // [SimpleDialog] with [CustomDayRadio] to change [Task]'s [Day]
  Future<void> changeDayWindow(
    BuildContext dayContext,
    Task item,
    ColorTheme theme,
  ) {
    void updateDay(int day) {
      Navigator.pop(dayContext);
      BlocProvider.of<TasksBloc>(dayContext).add(
        TaskUpdated(Task(item.timeStamp, item.task, item.priority, day)),
      );
    }

    return showDialog(
      barrierColor: theme.accent.withOpacity(0.3),
      context: dayContext,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: SimpleDialog(
          backgroundColor: theme.accent.withOpacity(0.85),
          elevation: 1,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          children: [
            Column(
              children: [
                CustomDayRadio(updateDay, item.day),
              ],
            )
          ],
        ),
      ),
    );
  }

  // [Dismissible] [ListTile] with a [PriorityRadioIcon] button,
  // [TaskTileTextField], & a [DayRadioIcon] button
  //
  // [TaskTile]s are the items displayed from the [TaskListView] builder
  @override
  Widget build(BuildContext context) {
    final taskItem = widget.taskItem;
    final theme = widget.theme;

    return Dismissible(
      key: UniqueKey(),
      // Add [TaskDeleted] event to [TasksBloc] when a tile is removed
      onDismissed: (direction) {
        BlocProvider.of<TasksBloc>(context).add(TaskDeleted(taskItem));
      },
      resizeDuration: const Duration(milliseconds: 750),
      // [Gradient] & [Text] to be displayed behind the [TaskTile] on dismissal
      background: Container(
        margin: const EdgeInsets.fromLTRB(0, 2.5, 0, 2.5),
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
          borderRadius: const BorderRadius.all(Radius.circular(6)),
        ),
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          dismissTextList[rand.nextInt(dismissTextList.length)],
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 2.5, 0, 2.5),
        padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
        decoration: BoxDecoration(
          color: taskItem.priority.color(theme),
          borderRadius: const BorderRadius.all(Radius.circular(6)),
        ),
        child: ListTile(
          visualDensity: const VisualDensity(horizontal: -1),
          // [PriorityyRadioIcon] button - for changing the [Priority]
          leading: GestureDetector(
            onTap: () {
              changePriorityWindow(context, taskItem, theme);
            },
            // Outlined [PriorityRadioIcon]
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
              child: PriorityRadioIcon(taskItem.priority.radio),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Editable [TaskTileTextField] to alter [Task]s text
              TaskTileTextField(taskItem),
              const Padding(padding: EdgeInsets.only(top: 5)),
              // [DayRadioIcon] button - for changing the [Day]
              GestureDetector(
                onTap: () {
                  changeDayWindow(context, taskItem, theme);
                },
                child: DayRadioIconTileSize(
                  DayRadio(
                    dayText:
                        Day(DateTime.now().weekday).dayOptions[taskItem.day],
                    isSelected: false,
                  ),
                ),
              ),
            ],
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
        ),
      ),
    );
  }
}
