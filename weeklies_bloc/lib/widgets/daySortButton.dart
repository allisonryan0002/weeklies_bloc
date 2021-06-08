import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/models/models.dart';

// Simple button that adds DaySorted() event when tapped
class DaySortButton extends StatefulWidget {
  @override
  _DaySortButtonState createState() => _DaySortButtonState();
}

class _DaySortButtonState extends State<DaySortButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        if (state is ThemeLoadSuccess) {
          final theme = state.theme.colorTheme;
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
              decoration: ShapeDecoration(
                shape: CircleBorder(),
              ),
              padding: EdgeInsets.all(8),
            ),
          );
        } else {
          //TODO: better way to address this
          return Container();
        }
      },
    );
  }
}
