import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    DateTime midnight = DateTime(now.year, now.month, now.day + 1, 0);
    Timer(Duration(minutes: midnight.difference(now).inMinutes + 3), () {
      BlocProvider.of<TasksBloc>(context).add(TasksLoaded());
      Timer.periodic(Duration(hours: 24), (timer) {
        BlocProvider.of<TasksBloc>(context).add(TasksLoaded());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        if (state is ThemeLoadSuccess) {
          ColorThemeOption currentTheme = state.theme;
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    changeThemeWindow(context, currentTheme);
                  },
                  icon: Icon(Icons.swap_horizontal_circle_rounded,
                      color: Colors.white),
                  //settings_outlined
                  //settings_rounded
                  //circle
                  //circle_outlined
                  //color_lens_outlined
                  //color_lens_rounded
                  //invert_colors_on_rounded
                  //account_circle_rounded
                  //change_circle_outlined
                  iconSize: 30,
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height / 50,
                      right: 15),
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
              backgroundColor: state.theme.colorTheme.low,
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(1000),
                      bottomRight: Radius.circular(1000))),
              toolbarHeight: MediaQuery.of(context).size.height / 15,
            ),
            // App body stacking the taskListView underneath the bottom button panel
            body: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                // TaskListView
                Flex(
                  direction: Axis.vertical,
                  children: <Widget>[Expanded(child: TaskListView())],
                ),
                /* Bottom button panel with PrioritySortButton, 
                * TaskInputWidget(button), & TimeSortButton
                * This panel sits on top of the taskListView with a white gradient so
                * the task list seamlessly disappears under the button panel
                */
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
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  changeThemeWindow(BuildContext themeContext, ColorThemeOption currentTheme) {
    changeTheme(ColorThemeOption theme) {
      Navigator.pop(themeContext);
      BlocProvider.of<ThemeBloc>(themeContext).add(ThemeChanged(theme));
      currentTheme = theme;
    }

    return showDialog(
      barrierColor: currentTheme.colorTheme.accent.withOpacity(0.3),
      context: themeContext,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: SimpleDialog(
          insetPadding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 4.6,
              vertical: 24),
          children: <Widget>[
            CustomColorThemeRadio(changeTheme, currentTheme),
          ],
          backgroundColor: currentTheme.colorTheme.accent.withOpacity(0.8),
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
        ),
      ),
    );
  }
}
