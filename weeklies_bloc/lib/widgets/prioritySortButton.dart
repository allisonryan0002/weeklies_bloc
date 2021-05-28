import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';

// Simple button that calls priorityTaskItemOrder() when tapped
class PrioritySortButton extends StatefulWidget {
  @override
  _PrioritySortButtonState createState() => _PrioritySortButtonState();
}

class _PrioritySortButtonState extends State<PrioritySortButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<TasksBloc>(context).add(PrioritySorted());
      },
      child: Container(
        child: Icon(
          Icons.format_list_numbered_rounded,
          color: Color.fromRGBO(225, 113, 76, 0.8),
          size: MediaQuery.of(context).size.height / 24,
        ),
        decoration: ShapeDecoration(
          shape: CircleBorder(),
        ),
        padding: EdgeInsets.all(8),
      ),
    );
  }
}
