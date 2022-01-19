import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/utility/utility.dart';

// Circular material element representing the [PriorityRadio] model
class PriorityRadioIcon extends StatelessWidget {
  const PriorityRadioIcon(this.model, {Key? key}) : super(key: key);

  final PriorityRadio model;

  @override
  Widget build(BuildContext context) {
    // [ColorTheme] to pull colors from
    final theme =
        context.select((ThemeBloc bloc) => bloc.state.theme.colorTheme);

    // Outer [Container] for displaying border indicating the model is selected
    return Container(
      //Inner circular [Container] with the model text and theme color
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: model.isSelected
            ? Border.all(
                color: model.priority.color(theme),
                width: 2,
              )
            : null,
      ),
      //Inner circular [Container] with the model text and theme color
      child: Container(
        constraints: const BoxConstraints(maxHeight: 30, maxWidth: 30),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: model.priority.color(theme),
        ),
        margin: const EdgeInsets.all(2.5),
        child: Center(
          child: Text(
            model.radioNumText,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: Colors.black.withOpacity(0.7)),
          ),
        ),
      ),
    );
  }
}

// Displays set of [PriorityRadioIcon]s (1-5) in a horizontal row
class CustomPriorityRadio extends StatefulWidget {
  const CustomPriorityRadio(this.callback, this.initialSelected, {Key? key})
      : super(key: key);

  // Relays currently selected [Priority] value to [TaskInputWidget]
  final Function(Priority) callback;

  // When [CustomPriorityRadio] is being built from an existing [Task], display
  // this [Priority] as the initially selected [PriorityRadioIcon]
  final Priority initialSelected;

  @override
  CustomPriorityRadioState createState() => CustomPriorityRadioState();
}

class CustomPriorityRadioState extends State<CustomPriorityRadio> {
  // List of [PriorityRadio] models for the [PriorityRadioIcon]s to be built
  // from
  late List<PriorityRadio> priorityRadios;

  // Stores the selected [PriorityRadioIcon]s corresponding [Priority] value to
  // be passed into the callback function upon [Task] creation
  late Priority priority;

  // Setup priorityRadios list with [PriorityRadio]s based on the
  // initialSelected
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
        physics: const NeverScrollableScrollPhysics(),
        itemCount: priorityRadios.length,
        itemBuilder: (context, index) {
          return IconButton(
            // Ensure only one button is selected at a time & rebuild to update
            onPressed: () {
              setState(() {
                for (final radio in priorityRadios) {
                  radio.isSelected = false;
                }
                priorityRadios[index].isSelected = true;
                priority = Priority.values[index];
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
