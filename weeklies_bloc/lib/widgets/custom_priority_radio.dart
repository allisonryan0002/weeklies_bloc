import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/utility/utility.dart';

// Circular material element representing the [PriorityRadio] model
class PriorityRadioIcon extends StatelessWidget {
  final PriorityRadio model;

  PriorityRadioIcon(this.model);

  @override
  Widget build(BuildContext context) {
    // [ColorTheme] to pull colors from
    final theme = BlocProvider.of<ThemeBloc>(context).state.theme.colorTheme;

    // Outer [Container] for displaying border indicating the model is selected
    return Container(
      //Inner circular [Container] with the model text and theme color
      child: Container(
        child: Center(
          child: Text(
            model.radioNumText,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: Colors.black.withOpacity(0.7)),
          ),
        ),
        constraints: BoxConstraints(maxHeight: 30, maxWidth: 30),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: model.priority.color(theme),
        ),
        margin: EdgeInsets.all(2.5),
      ),
      // Conditional circular border/ring
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: model.isSelected
            ? Border.all(
                color: model.priority.color(theme),
                width: 2,
              )
            : null,
      ),
    );
  }
}

// Displays set of [PriorityRadioIcon]s (1-5) in a horizontal row
class CustomPriorityRadio extends StatefulWidget {
  // Relays currently selected [Priority] value to [TaskInputWidget]
  final Function(Priority) callback;

  // When [CustomPriorityRadio] is being built from an existing [Task], display
  // this [Priority] as the initially selected [PriorityRadioIcon]
  final Priority initialSelected;

  CustomPriorityRadio(this.callback, this.initialSelected);

  @override
  _CustomPriorityRadioState createState() => _CustomPriorityRadioState();
}

class _CustomPriorityRadioState extends State<CustomPriorityRadio> {
  // List of [PriorityRadio] models for the [PriorityRadioIcon]s to be built from
  late List<PriorityRadio> priorityRadios;

  // Stores the selected [PriorityRadioIcon]s corresponding [Priority] value to
  // be passed into the callback function upon [Task] creation
  late Priority priority;

  // Setup priorityRadios list with [PriorityRadio]s based on the initialSelected
  @override
  void initState() {
    super.initState();
    priorityRadios = generatePriorityRadioList(widget.initialSelected);
  }

  // Unscrollable, horizontal [ListView] displaying all 5 [PriorityRadioIcon]s
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        itemCount: priorityRadios.length,
        itemBuilder: (context, index) {
          return IconButton(
            // Ensure only one button is selected at a time & rebuild to update
            onPressed: () {
              setState(() {
                this.priorityRadios.forEach((element) {
                  element.isSelected = false;
                });
                this.priorityRadios[index].isSelected = true;
                this.priority = Priority.values[index];
              });
              widget.callback(priority);
            },
            icon: PriorityRadioIcon(priorityRadios[index]),
            splashRadius: 0.1,
          );
        },
      ),
    );
  }
}
