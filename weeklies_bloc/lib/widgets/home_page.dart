import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/widgets/widgets.dart';

/// The base screen for all app interactions
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Upon launching the app, start a [Timer] set for midnight to update [Task.day]
  //
  // This operation is only necessary for users who leave the app open or open
  // in the background overnight. Otherwise, [Task.day] is updated upon
  // launching the app.
  @override
  void initState() {
    super.initState();
    // Use the current time to find the nearest midnight
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day + 1, 0);
    // [Timer] counts down minutes until midnight
    Timer(Duration(minutes: midnight.difference(now).inMinutes + 3), () {
      // At midnight, trigger [TasksLoaded] event to update [Task.day]
      BlocProvider.of<TasksBloc>(context).add(TasksLoaded());
      // Periodic [Timer] set for subsequent days that the app is left open
      Timer.periodic(Duration(hours: 24), (timer) {
        BlocProvider.of<TasksBloc>(context).add(TasksLoaded());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // [ColorThemeOption] to pull app component colors from
    final currentTheme = BlocProvider.of<ThemeBloc>(context).state.theme;

    // Main screen of app
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              changeThemeWindow(context, currentTheme);
            },
            icon:
                Icon(Icons.swap_horizontal_circle_rounded, color: Colors.white),
            iconSize: 30,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 50, right: 15),
          )
        ],
        title: Column(
          children: <Widget>[
            Text(
              'Weeklies',
              style: Theme.of(context).textTheme.headline1,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 50),
            )
          ],
        ),
        centerTitle: true,
        backgroundColor:
            BlocProvider.of<ThemeBloc>(context).state.theme.colorTheme.low,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(1000),
                bottomRight: Radius.circular(1000))),
        toolbarHeight: MediaQuery.of(context).size.height / 15,
      ),
      // App body stacking the [TaskListView] underneath the bottom button panel
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // [TaskListView] at the bottom of the [Stack]
          Flex(
            direction: Axis.vertical,
            children: <Widget>[Expanded(child: TaskListView())],
          ),

          // Bottom button panel with [PrioritySortButton],
          // [TaskInputWidget](button), & [TimeSortButton]
          //
          // This panel sits on top of the [TaskListView] with a white gradient
          // so the task list seamlessly disappears under the button panel
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.only(top: 80, bottom: 15),
                child: Row(
                  children: <Widget>[
                    PrioritySortButton(),
                    TaskInputWidget(),
                    DaySortButton(),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0),
                      Colors.white.withOpacity(0.9),
                      Colors.white.withOpacity(0.97),
                      Colors.white,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // Prevent keyboard from covering existing task when editing its text
      resizeToAvoidBottomInset: false,
    );
  }

  // Produces [SimpleDialog] with [CustomColorThemeRadio] for changing app theme
  changeThemeWindow(BuildContext themeContext, ColorThemeOption currentTheme) {
    // Adds [ThemeChanged] event with user's selected [ColorThemeOption] &
    // closes [SimpleDialog]
    changeTheme(ColorThemeOption theme) {
      Navigator.pop(themeContext);
      BlocProvider.of<ThemeBloc>(themeContext).add(ThemeChanged(theme));
    }

    return showDialog(
      context: themeContext,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: SimpleDialog(
          children: <Widget>[
            CustomColorThemeRadio(changeTheme, currentTheme),
          ],
          backgroundColor: currentTheme.colorTheme.accent.withOpacity(0.8),
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          insetPadding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 4.6,
              vertical: 24),
        ),
      ),
      barrierColor: currentTheme.colorTheme.accent.withOpacity(0.3),
    );
  }
}
