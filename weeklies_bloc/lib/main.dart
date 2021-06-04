/* App Name: Weeklies
 *
 * Description: Productivity app for creating and managing weekly tasks. Tasks 
 *              are stored in a single list, each with a priority label (1-5) 
 *              and a day of the week to be completed by. Users can choose to 
 *              sort the list by priority or completion time. Created tasks are
 *              fully editable and can be swiped away once completed. The app
 *              has a minimalistic design for quick and simple task management.
 * 
 * Author: Allison Ryan
 * 
 * Version Date: 5/26/2021
 * 
 * Author's Note: I created this app as a fun personal project and beacause I 
 *                felt no other task management apps had a simple, weekly style
 *                that allowed me to create a task in a way that didn't feel
 *                cumbersome. Creating a task in the app feels similar to
 *                jotting down a note on paper and doesn't require a myriad of
 *                selections to be made (time, date, notification, etc.) to make
 *                a task. I also created the app as a challenge for myself, as
 *                it's my first largely UI based project. It was a great 
 *                learning experience and is intended for my personal use and as
 *                a showcase of skill. Screenshots and a video demo of the app 
 *                can be found in AppScreenshots folder.
 */

import 'dart:ui';
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/clients/clients.dart';
import 'package:weeklies/repositories/repositories.dart';
import 'package:weeklies/widgets/widgets.dart';

//TODO: occasionally reload tasks to check for day changes...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  final fileClient = FileClient(dir: dir, fileSystem: LocalFileSystem());
  runApp(MyApp(
    client: fileClient,
  ));
}

class MyApp extends StatelessWidget {
  final FileClient client;

  MyApp({required this.client});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TaskRepository(client: client),
      child: BlocProvider(
        create: (context) => TasksBloc(
          tasksRepository: RepositoryProvider.of<TaskRepository>(context),
        )..add(TasksLoaded()),
        child: MaterialApp(
          title: 'Weeklies',
          theme: ThemeData(
            textTheme: TextTheme(
              // AppBar title
              headline1: GoogleFonts.rockSalt(
                  fontSize: 24,
                  color: Colors.white,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold),
              // Text behind dismissing task
              headline2: GoogleFonts.righteous(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
              // Font for priority radio buttons, task text, and taskTextField
              bodyText1: GoogleFonts.karla(
                  fontSize: 20, color: Colors.black.withOpacity(0.9)),
              // Font for time radio buttons
              subtitle1: GoogleFonts.righteous(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: HomePage(),
        ),
      ),
    );
  }
}
