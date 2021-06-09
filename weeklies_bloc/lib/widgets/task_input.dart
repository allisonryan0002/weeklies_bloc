import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/widgets/widgets.dart';
import 'package:weeklies/models/models.dart';

/* Widget displaying 'add task' button and creating input dialog window on tap
 * Maintains a single task's data and passes information to taskList.dart
 * methods for task creation 
 */
class TaskInputWidget extends StatefulWidget {
  @override
  _TaskInputWidgetState createState() => _TaskInputWidgetState();
}

class _TaskInputWidgetState extends State<TaskInputWidget> {
  // Variables for storing and managing task data
  Priority priority = Priority.med;
  int day = 1;
  final controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void updatePriority(Priority priority) {
    setState(() {
      this.priority = priority;
    });
  }

  void updateDay(int day) {
    setState(() {
      this.day = day;
    });
  }

  // Pass current task input data to newTaskItem method and close dialog box
  void createTaskClick(BuildContext taskInputContext) {
    Navigator.pop(taskInputContext);
    BlocProvider.of<TasksBloc>(taskInputContext).add(TaskAdded(
        Task(DateTime.now(), controller.text, this.priority, this.day)));
    controller.clear();
  }

  // SimpleDialog window containing priority & time radio sets and a TextField
  //TODO: make the PriorityRadioIcons larger
  createTaskWindow(BuildContext taskInputContext, ColorTheme theme) {
    print(day);
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
                    onEditingComplete: () => createTaskClick(taskInputContext),
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
                //TaskTextField(Task(DateTime.now(), 'TEST', Priority.low, 1))
              ],
            ),
          ],
          backgroundColor: theme.accent.withOpacity(0.85),
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.fromLTRB(14, 10, 14, 10),
        ),
      ),
    );
  }

  // 'add task' button
  @override
  Widget build(BuildContext context) {
    final theme = BlocProvider.of<ThemeBloc>(context).state.theme.colorTheme;
    return GestureDetector(
      onTap: () {
        // Reset priority & time values to match radio defaults
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
