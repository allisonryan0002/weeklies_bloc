import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/utility/utility.dart';
import 'package:weeklies/widgets/widgets.dart';
import 'package:weeklies/models/models.dart';

// Custom [ListView] displaying [Task]s based on the current [SortType]
//
// There are two distinct ways this widget is built: one for [SortType.priority]
// and one for [SortType.day]
class TaskListView extends StatefulWidget {
  @override
  _TaskListViewState createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  @override
  Widget build(BuildContext context) {
    // [ColorTheme] to pull theme colors from
    final theme = BlocProvider.of<ThemeBloc>(context).state.theme.colorTheme;

    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        if (state is TasksLoadInProgress) {
          return Center(child: CircularProgressIndicator());
          // When there are [Task]s, build one of the sorting views
        } else if (state is TasksLoadSuccess) {
          final sort = state.sort;
          final tasks = state.tasks;
          // [SortType.priority] build - single list of [TaskTile]s by priority
          if (sort == SortType.priority) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // [TaskTile]s surrounded by colored container
                  Container(
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 5),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        var taskItem = tasks[index];
                        return TaskTile(taskItem, theme);
                      },
                    ),
                    padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                    margin: EdgeInsets.fromLTRB(5, 8, 5, 0),
                    decoration: BoxDecoration(
                      color: theme.accent,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  // Invisible container to let [TaskTile]s sit above white gradient
                  Container(
                    height: MediaQuery.of(context).size.height / 5.5,
                  ),
                ],
              ),
            );
            // [SortType.day] build - list of days containing [TaskTile] sublists
          } else {
            // Days paired with their corresponding [Task]s
            Map<String, dynamic> taskAndIndex = getDaysAndTasks(tasks);

            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: ListView.builder(
                key: Key('day_sort_outer_list_view'),
                itemCount: taskAndIndex.length + 1,
                itemBuilder: (context, index) {
                  // Invisible container to let [TaskTile]s sit above white gradient
                  if (index == taskAndIndex.length) {
                    return Container(
                      height: MediaQuery.of(context).size.height / 5.5,
                    );
                  } else {
                    // Box surrounding sublist of [TaskTile]s
                    return Container(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            // Display the day corresponding to the [Task] sublist
                            child: Text(
                              taskAndIndex.keys.toList()[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(fontSize: 18),
                            ),
                          ),
                          // Building sublist of [TaskTile]s
                          ListView.builder(
                            key: Key('day_sort_inner_list_view'),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                taskAndIndex.values.toList()[index].length,
                            itemBuilder: (context, indexInner) {
                              Task taskItem = taskAndIndex.values
                                  .toList()[index][indexInner][0];
                              return TaskTile(taskItem, theme);
                            },
                          ),
                        ],
                      ),
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 5),
                      margin: EdgeInsets.fromLTRB(5, 8, 5, 0),
                      decoration: BoxDecoration(
                        color: theme.accent,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    );
                  }
                },
              ),
            );
          }
          // Both [TaskState]s are evaluated above - this condition won't be reached
        } else {
          return Container();
        }
      },
    );
  }
}
