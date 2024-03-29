import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/blocs/tasks/tasks_bloc.dart';
import 'package:weeklies/models/models.dart';

// Custom [TextField] used to edit [Task]s in the [TaskListView] [ListTile]s
class TaskTileTextField extends StatefulWidget {
  const TaskTileTextField(this.item, {Key? key}) : super(key: key);

  final Task item;

  @override
  TaskTileTextFieldState createState() => TaskTileTextFieldState();
}

class TaskTileTextFieldState extends State<TaskTileTextField> {
  final controller = TextEditingController();

  // Initialize to display [Task] text and start editing at the end of the text
  @override
  void initState() {
    super.initState();
    controller.text = widget.item.task;
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  // Stylized [TextField] that interacts with the [TaskBloc]
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: Theme.of(context).textTheme.bodyText1,
      textInputAction: TextInputAction.done,
      // Add [TaskUpdated] event with the modified [Task] to the [TasksBloc]
      onEditingComplete: () {
        final task = Task(
          widget.item.timeStamp,
          controller.text,
          widget.item.priority,
          widget.item.day,
        );
        context.read<TasksBloc>().add(TaskUpdated(task));
      },
      onSubmitted: (_) {
        final task = Task(
          widget.item.timeStamp,
          controller.text,
          widget.item.priority,
          widget.item.day,
        );
        context.read<TasksBloc>().add(TaskUpdated(task));
      },
      keyboardType: TextInputType.multiline,
      maxLines: null,
      textCapitalization: TextCapitalization.sentences,
      decoration: const InputDecoration(
        border: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.only(top: 3, bottom: 3),
      ),
      cursorColor: Colors.black12,
      cursorHeight: 18,
      cursorWidth: 1.5,
    );
  }
}
