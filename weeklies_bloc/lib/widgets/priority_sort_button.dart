import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/models/models.dart';

// Simple button that calls [PrioritySorted] [TasksBloc] event when tapped
class PrioritySortButton extends StatefulWidget {
  const PrioritySortButton({Key? key}) : super(key: key);

  @override
  PrioritySortButtonState createState() => PrioritySortButtonState();
}

class PrioritySortButtonState extends State<PrioritySortButton> {
  @override
  Widget build(BuildContext context) {
    // [ColorTheme] to pull colors from
    final theme =
        context.select((ThemeBloc bloc) => bloc.state.theme.colorTheme);

    return GestureDetector(
      onTap: () {
        context.read<TasksBloc>().add(PrioritySorted());
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Icon(
          Icons.format_list_numbered_rounded,
          color: theme.high,
          size: 4.2.h,
        ),
      ),
    );
  }
}
