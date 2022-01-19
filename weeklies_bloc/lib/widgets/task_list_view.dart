import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/utility/utility.dart';
import 'package:weeklies/widgets/widgets.dart';

// Custom [ListView] displaying [Task]s based on the current [SortType]
//
// There are two distinct ways this widget is built: one for [SortType.priority]
// and one for [SortType.day]
class TaskListView extends StatefulWidget {
  const TaskListView({Key? key}) : super(key: key);

  @override
  TaskListViewState createState() => TaskListViewState();
}

class TaskListViewState extends State<TaskListView> {
  @override
  Widget build(BuildContext context) {
    // [ColorTheme] to pull theme colors from
    final theme =
        context.select((ThemeBloc bloc) => bloc.state.theme.colorTheme);

    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        if (state is TasksLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
          // When there are [Task]s, build one of the sorting views
        } else if (state is TasksLoadSuccess) {
          final sort = state.sort;
          final tasks = state.tasks;
          // [SortType.priority] build - single list of [TaskTile]s by priority
          if (sort == SortType.priority) {
            if (tasks.isEmpty) {
              return Container();
            }
            return Scaffold(
              resizeToAvoidBottomInset: true,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    // [TaskTile]s surrounded by colored container
                    Container(
                      padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                      margin: const EdgeInsets.fromLTRB(5, 8, 5, 0),
                      decoration: BoxDecoration(
                        color: theme.accent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 5),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final taskItem = tasks[index];
                          return TaskTile(taskItem, theme);
                        },
                      ),
                    ),
                    // Invisible container to let [TaskTile]s sit above white
                    // gradient
                    Container(
                      height: 18.2.h,
                    ),
                  ],
                ),
              ),
            );
            // [SortType.day] builds list of days containing [TaskTile] sublists
          } else {
            // Days paired with their corresponding [Task]s
            final taskAndIndex = getDaysAndTasks(tasks);

            return Scaffold(
              resizeToAvoidBottomInset: true,
              body: ListView.builder(
                key: const Key('day_sort_outer_list_view'),
                itemCount: taskAndIndex.length + 1,
                itemBuilder: (context, index) {
                  // Invisible container to let [TaskTile]s sit above white
                  // gradient
                  if (index == taskAndIndex.length) {
                    return Container(
                      height: 18.2.h,
                    );
                  } else {
                    // Box surrounding sublist of [TaskTile]s
                    return Container(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 5),
                      margin: const EdgeInsets.fromLTRB(5, 8, 5, 0),
                      decoration: BoxDecoration(
                        color: theme.accent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            // Display the day corresponding to the [Task]
                            // sublist
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
                            key: const Key('day_sort_inner_list_view'),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                taskAndIndex.values.toList()[index].length,
                            itemBuilder: (context, indexInner) {
                              final taskItem = taskAndIndex.values
                                  .toList()[index][indexInner][0] as Task;
                              return TaskTile(taskItem, theme);
                            },
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            );
          }
          // Both [TaskState]s are evaluated above - this condition won't be
          // reached
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
