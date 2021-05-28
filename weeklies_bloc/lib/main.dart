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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/clients/file_client.dart';
import 'package:weeklies/repository/task_repository.dart';
import 'package:weeklies/widgets/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final fileClient = await FileClient.instance;
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
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Setup file for data storage and if a file exists, read the file data
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksBloc(
        tasksRepository: RepositoryProvider.of<TaskRepository>(context),
      )..add(TasksLoaded()),
      child: Scaffold(
        // Non-interactive AppBar simply for displaying the app name
        appBar: AppBar(
          title: Column(
            children: <Widget>[
              Text(
                'Weeklies',
                style: Theme.of(context).textTheme.headline1,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 55),
              )
            ],
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(86, 141, 172, 1),
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
            // taskListView
            Flex(
              direction: Axis.vertical,
              children: <Widget>[Expanded(child: TaskListView())],
            ),
            /* Bottom button panel with PrioritySortButton, 
               * TaskInputWidget(button), & TimeSortButton
               * This panel sits on top of the taskListView with a white gradient so
               * the task list seamlessly disappears under the button panel
               */
            // BottomNavigationBar(
            //   items: [
            //     BottomNavigationBarItem(icon: PrioritySortButton(), label: '1'),
            //     BottomNavigationBarItem(icon: TaskInputWidget(), label: '2'),
            //     BottomNavigationBarItem(icon: TimeSortButton(), label: '3'),
            //   ],
            //   showSelectedLabels: false,
            //   showUnselectedLabels: false,
            // ),
            //IgnorePointer(child:
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
                      TimeSortButton(),
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
            //),
          ],
        ),
        // Prevent keyboard from covering existing task when editing its text
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
