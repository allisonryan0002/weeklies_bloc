import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/blocs/tasks/tasks_bloc.dart';
import 'package:weeklies/models/models.dart';

// Custom TextField used to input tasks and edit existing tasks
class TaskTextField extends StatefulWidget {
  final Task item;

  TaskTextField(this.item);

  @override
  _TaskTextFieldState createState() => _TaskTextFieldState();
}

class _TaskTextFieldState extends State<TaskTextField> {
  final controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.item.task;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.controller,
      key: Key(widget.item.timeStamp.toString()),
      style: Theme.of(context).textTheme.bodyText1,
      textInputAction: TextInputAction.done,
      onEditingComplete: () {
        Task task = Task(widget.item.timeStamp, controller.text,
            widget.item.priority, widget.item.day);
        BlocProvider.of<TasksBloc>(context).add(TaskUpdated(task));
      },
      keyboardType: TextInputType.multiline,
      maxLines: null,
      textCapitalization: TextCapitalization.sentences,
      decoration: null,
    );
  }
}
