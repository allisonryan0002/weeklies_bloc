import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/models/models.dart';

// Simple button that calls priorityTaskItemOrder() when tapped
class PrioritySortButton extends StatefulWidget {
  @override
  _PrioritySortButtonState createState() => _PrioritySortButtonState();
}

class _PrioritySortButtonState extends State<PrioritySortButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        if (state is TasksLoadSuccess) {
          return GestureDetector(
            onTap: () {
              BlocProvider.of<TasksBloc>(context).add(PrioritySorted());
            },
            child: Container(
              child: Icon(
                Icons.format_list_numbered_rounded,
                color: state.theme.colorTheme.medHigh,
                size: MediaQuery.of(context).size.height / 24,
              ),
              decoration: ShapeDecoration(
                shape: CircleBorder(),
              ),
              padding: EdgeInsets.all(8),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
