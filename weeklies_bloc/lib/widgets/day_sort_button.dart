import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/models/models.dart';

// Simple button that adds [DaySorted] [TasksBloc] event when tapped
class DaySortButton extends StatefulWidget {
  const DaySortButton({Key? key}) : super(key: key);

  @override
  DaySortButtonState createState() => DaySortButtonState();
}

class DaySortButtonState extends State<DaySortButton> {
  @override
  Widget build(BuildContext context) {
    // [ColorTheme] to pull colors from
    final theme = BlocProvider.of<ThemeBloc>(context).state.theme.colorTheme;

    return GestureDetector(
      onTap: () {
        BlocProvider.of<TasksBloc>(context).add(DaySorted());
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Icon(Icons.access_time_rounded, color: theme.med, size: 4.2.h),
      ),
    );
  }
}
