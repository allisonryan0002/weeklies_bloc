import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/models/models.dart';

// Simple button that adds [DaySorted] [TasksBloc] event when tapped
class DaySortButton extends StatefulWidget {
  @override
  _DaySortButtonState createState() => _DaySortButtonState();
}

class _DaySortButtonState extends State<DaySortButton> {
  @override
  Widget build(BuildContext context) {
    // [ColorTheme] to pull colors from
    final theme = BlocProvider.of<ThemeBloc>(context).state.theme.colorTheme;

    return GestureDetector(
      onTap: () {
        BlocProvider.of<TasksBloc>(context).add(DaySorted());
      },
      child: Container(
        child: Icon(
          Icons.access_time_rounded,
          color: theme.med,
          size: MediaQuery.of(context).size.height / 24,
        ),
        padding: EdgeInsets.all(8),
      ),
    );
  }
}
