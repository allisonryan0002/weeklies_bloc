/* App Name: Weeklies
 *
 * Description: Productivity app for creating and managing weekly tasks. Tasks 
 *              are stored in a single list, each with a priority label (1-5) 
 *              and a day of the week to be completed by. Users can choose to 
 *              sort the list by priority or completion day. Created tasks are
 *              fully editable and can be swiped away once completed. The app
 *              has a minimalistic design for quick and simple task management.
 * 
 * Author: Allison Ryan
 * 
 * Version Date: 6/9/2021
 * 
 * Author's Note: I created this app as a fun personal project and beacause I 
 *                felt no other task management apps had a simple, weekly style
 *                that allowed me to create a task in a way that didn't feel
 *                cumbersome. Creating a task in the app feels similar to
 *                jotting down a note on paper and doesn't require a myriad of
 *                selections to be made (time, date, notification, etc.) to make
 *                a task. I also created the app as a challenge for myself, as
 *                it's my first project using Flutter.  
 */

import 'dart:ui';
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/clients/clients.dart';
import 'package:weeklies/models/color_theme.dart';
import 'package:weeklies/repositories/repositories.dart';
import 'package:weeklies/widgets/widgets.dart';

//TODO: fix random "resorts"

void main() async {
  // Setup [FileClient] for application access to local storage
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  final fileClient = FileClient(dir: dir, fileSystem: LocalFileSystem());

  // Setup [TaskRepository] & load stored [ColorThemeOption] from it
  final tasksRepository = TaskRepository(client: fileClient);
  final themeRepository = ThemeRepository(client: fileClient);
  final theme = await themeRepository.loadTheme();

  // Start the app with the repository & loaded theme
  runApp(MyApp(
    tasksRepository: tasksRepository,
    themeRepository: themeRepository,
    theme: theme,
  ));
}

class MyApp extends StatelessWidget {
  final TaskRepository tasksRepository;
  final ThemeRepository themeRepository;
  final ColorThemeOption theme;

  MyApp(
      {required this.tasksRepository,
      required this.themeRepository,
      required this.theme});

  @override
  Widget build(BuildContext context) {
    // Provide [TasksRepository], [TasksBloc], & [ThemeBloc] to tree
    return RepositoryProvider.value(
      value: this.themeRepository,
      child: RepositoryProvider.value(
        value: this.tasksRepository,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => TasksBloc(
                taskRepository: RepositoryProvider.of<TaskRepository>(context),
              )..add(TasksLoaded()),
            ),
            BlocProvider(
              create: (context) => ThemeBloc(
                  themeRepository:
                      RepositoryProvider.of<ThemeRepository>(context),
                  initialTheme: theme),
            ),
          ],
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                title: 'Weeklies',
                // TextThemes for all text components
                theme: ThemeData(
                  scaffoldBackgroundColor: state.theme.colorTheme.background,
                  textTheme: TextTheme(
                    // AppBar title
                    headline1: GoogleFonts.rockSalt(
                        fontSize: 28,
                        color: Colors.white,
                        letterSpacing: 4,
                        fontWeight: FontWeight.bold),
                    // Text behind dismissing task
                    headline2: GoogleFonts.righteous(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.normal),
                    // Font for priority radio icons, task text, and taskTextField
                    bodyText1: GoogleFonts.karla(
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                    // Font for time radio icons
                    subtitle1: GoogleFonts.righteous(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.normal),
                  ),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                debugShowCheckedModeBanner: false,
                home: HomePage(),
              );
            },
          ),
        ),
      ),
    );
  }
}
