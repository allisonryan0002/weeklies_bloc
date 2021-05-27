import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';

// Simple button that calls timeTaskItemOrder() when tapped
class TimeSortButton extends StatefulWidget {
  @override
  _TimeSortButtonState createState() => _TimeSortButtonState();
}

class _TimeSortButtonState extends State<TimeSortButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<TasksBloc>(context).add(TimeSorted());
      },
      child: Container(
        child: Icon(
          Icons.access_time_rounded,
          color: Color.fromRGBO(254, 203, 93, 0.9),
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
