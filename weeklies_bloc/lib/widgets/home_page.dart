import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/widgets/widgets.dart';

/// The base screen for all app interactions
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // Upon launching the app, start a [Timer] set for midnight to update
  // [Task.day]
  //
  // This operation is only necessary for users who leave the app open or open
  // in the background overnight. Otherwise, [Task.day] is updated upon
  // launching the app.
  @override
  void initState() {
    super.initState();
    // Use the current time to find the nearest midnight
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day + 1);
    // [Timer] counts down minutes until midnight
    Timer(Duration(minutes: midnight.difference(now).inMinutes + 3), () {
      // At midnight, trigger [TasksLoaded] event to update [Task.day]
      context.read<TasksBloc>().add(TasksLoaded());
      // Periodic [Timer] set for subsequent days that the app is left open
      Timer.periodic(const Duration(hours: 24), (timer) {
        context.read<TasksBloc>().add(TasksLoaded());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // [ColorThemeOption] to pull app component colors from
    final currentTheme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final backgroundColor = currentTheme.colorTheme.background;

    // Main screen of app
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    changeThemeWindow(context, currentTheme);
                  },
                  icon: const Icon(
                    Icons.swap_horizontal_circle_rounded,
                    color: Colors.white,
                  ),
                  iconSize: 30,
                  padding: EdgeInsets.only(bottom: 2.h, right: 4.w),
                )
              ],
              title: Column(
                children: [
                  Text(
                    'Weeklies',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                  )
                ],
              ),
              centerTitle: true,
              backgroundColor: currentTheme.colorTheme.low,
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(1000),
                  bottomRight: Radius.circular(1000),
                ),
              ),
              toolbarHeight: 6.7.h,
            ),
            // App body stacking the [TaskListView] underneath the bottom button
            // panel
            body: Stack(
              fit: StackFit.expand,
              children: [
                // [TaskListView] at the bottom of the [Stack]
                Flex(
                  direction: Axis.vertical,
                  children: const [Expanded(child: TaskListView())],
                ),

                // Bottom button panel with [PrioritySortButton],
                // [TaskInputWidget](button), & [TimeSortButton]
                //
                // This panel sits on top of the [TaskListView] with a white
                // gradient so the task list seamlessly disappears under the
                // button panel
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    height: 20.h,
                    width: 100.w,
                    child: Container(
                      padding: const EdgeInsets.only(top: 80, bottom: 15),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            backgroundColor.withOpacity(0),
                            backgroundColor.withOpacity(0.9),
                            backgroundColor.withOpacity(0.97),
                            backgroundColor,
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          PrioritySortButton(),
                          TaskInputWidget(),
                          DaySortButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Prevent keyboard from covering existing task when editing its
            // text
            resizeToAvoidBottomInset: false,
          ),
        );
      },
    );
  }

  // Produces [SimpleDialog] with [CustomColorThemeRadio] for changing app theme
  Future<void> changeThemeWindow(
    BuildContext themeContext,
    ColorThemeOption currentTheme,
  ) {
    // Adds [ThemeChanged] event with user's selected [ColorThemeOption] &
    // closes [SimpleDialog]
    void changeTheme(ColorThemeOption theme) {
      Navigator.pop(themeContext);
      themeContext.read<ThemeBloc>().add(ThemeChanged(theme));
    }

    return showDialog<void>(
      context: themeContext,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: SimpleDialog(
          backgroundColor: currentTheme.colorTheme.accent.withOpacity(0.8),
          elevation: 1,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          insetPadding:
              EdgeInsets.symmetric(horizontal: 21.7.w, vertical: 30.h),
          children: [
            CustomColorThemeRadio(changeTheme, currentTheme),
          ],
        ),
      ),
      barrierColor: currentTheme.colorTheme.accent.withOpacity(0.3),
    );
  }
}
