import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/models/models.dart';

// Simple button that calls [PrioritySorted] [TasksBloc] event when tapped
class PrioritySortButton extends StatefulWidget {
  @override
  _PrioritySortButtonState createState() => _PrioritySortButtonState();
}

class _PrioritySortButtonState extends State<PrioritySortButton> {
  @override
  Widget build(BuildContext context) {
    // [ColorTheme] to pull colors from
    final theme = BlocProvider.of<ThemeBloc>(context).state.theme.colorTheme;

    return GestureDetector(
      onTap: () {
        BlocProvider.of<TasksBloc>(context).add(PrioritySorted());
      },
      child: Container(
        child: Icon(
          Icons.format_list_numbered_rounded,
          color: theme.high,
          size: MediaQuery.of(context).size.height / 24,
        ),
        padding: EdgeInsets.all(8),
      ),
    );
  }
}
