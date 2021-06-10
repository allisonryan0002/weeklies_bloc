import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/widgets/widgets.dart';
import 'package:weeklies/models/models.dart';

// [IconButton] that displays a task input dialog window
//
// Maintains user's selections/inputs and adds [TaskAdded] event to [TasksBloc]
// to create a [Task] with inputted values
class TaskInputWidget extends StatefulWidget {
  @override
  _TaskInputWidgetState createState() => _TaskInputWidgetState();
}

class _TaskInputWidgetState extends State<TaskInputWidget> {
  // Variables for storing and maintaining [Priority], [Day], & text input
  Priority priority = Priority.med;
  int day = 1;
  final controller = new TextEditingController();

  // Callback function passed to [CustomPriorityRadio] for reflecting user selection
  void updatePriority(Priority priority) {
    setState(() {
      this.priority = priority;
    });
  }

  // Callback function passed to [CustomDayRadio] for reflecting user selection
  void updateDay(int day) {
    setState(() {
      this.day = day;
    });
  }

  // Adds [TaskAdded] event with user's input and closes the input window
  void createTask(BuildContext taskInputContext) {
    Navigator.pop(taskInputContext);
    BlocProvider.of<TasksBloc>(taskInputContext).add(TaskAdded(
        Task(DateTime.now(), controller.text, this.priority, this.day)));
    controller.clear();
  }

  // [SimpleDialog] window with [CustomPriorityRadio], [CustomDayRadio], & [TextField]
  createTaskWindow(BuildContext taskInputContext, ColorTheme theme) {
    return showDialog(
      barrierColor: theme.accent.withOpacity(0.3),
      context: taskInputContext,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: SimpleDialog(
          children: <Widget>[
            Column(
              children: <Widget>[
                CustomPriorityRadio(this.updatePriority, this.priority),
                CustomDayRadio(this.updateDay, this.day),
                Container(
                  child: TextField(
                    controller: this.controller,
                    autofocus: true,
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () => createTask(taskInputContext),
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: EdgeInsets.fromLTRB(4, 6, 4, 6),
                      isCollapsed: true,
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: Colors.white),
                    cursorColor: Colors.white,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: Colors.black12.withOpacity(0.2),
                  ),
                  padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                  margin: EdgeInsets.fromLTRB(2, 6, 2, 6),
                ),
                //TaskTileTextField(Task(DateTime.now(), 'TEST', Priority.low, 1))
                // ^ For testing TaskTileTextField keyboard issue
              ],
            ),
          ],
          backgroundColor: theme.accent.withOpacity(0.85),
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.fromLTRB(14, 10, 14, 10),
          insetPadding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 6, vertical: 24),
        ),
      ),
    );
  }

  // 'Add' icon button to bring up task creation [SimpleDialog] window
  @override
  Widget build(BuildContext context) {
    // [ColorThemeOption] to pull colors from
    final theme = BlocProvider.of<ThemeBloc>(context).state.theme.colorTheme;

    return GestureDetector(
      onTap: () {
        // Reset priority & time values to match what the radios display on default
        priority = Priority.med;
        day = 1;
        createTaskWindow(context, theme);
      },
      child: Container(
        child: Icon(
          Icons.add_circle_outline_rounded,
          color: theme.low,
          size: MediaQuery.of(context).size.height / 14,
        ),
        padding: EdgeInsets.all(6),
      ),
    );
  }
}
