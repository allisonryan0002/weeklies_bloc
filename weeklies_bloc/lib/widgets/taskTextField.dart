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
  //late final _formKey;

  @override
  void initState() {
    super.initState();
    controller.text = widget.item.task;
    controller.selection =
        TextSelection.collapsed(offset: controller.text.length);
    //(TextPosition(offset: controller.text.length));
    //_formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: ValueKey(widget.item.timeStamp),
      //autofocus: true,
      controller: this.controller,
      style: Theme.of(context).textTheme.bodyText1,
      textInputAction: TextInputAction.done,
      onEditingComplete: () {
        print('editing complete');
        Task task = Task(widget.item.timeStamp, controller.text,
            widget.item.priority, widget.item.day);
        BlocProvider.of<TasksBloc>(context).add(TaskUpdated(task));
        FocusScope.of(context).unfocus();
      },
      keyboardType: TextInputType.multiline,
      maxLines: null,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
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
