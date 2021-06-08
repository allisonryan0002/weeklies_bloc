import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/models/models.dart';

// Circular UI element representing the radio model
class PriorityRadioIcon extends StatelessWidget {
  final PriorityRadio item;
  PriorityRadioIcon(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Center(
          child: Text(
            item.radioNumText,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: Colors.black.withOpacity(0.7)),
          ),
        ),
        constraints: BoxConstraints(maxHeight: 30, maxWidth: 30),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: item.color,
        ),
        margin: EdgeInsets.all(2.5),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: item.isSelected
            ? Border.all(
                color: item.color,
                width: 2,
              )
            : null,
      ),
    );
  }
}

// Widget containing set of priority radio buttons (1-5)
class CustomPriorityRadio extends StatefulWidget {
  final Function(Priority) callback;
  final Priority initialSelected;

  CustomPriorityRadio(this.callback, this.initialSelected);

  @override
  _CustomPriorityRadioState createState() => _CustomPriorityRadioState();
}

class _CustomPriorityRadioState extends State<CustomPriorityRadio> {
  List<PriorityRadio> priorityRadios = [];
  late Priority priority;
  bool initialized = false;

  @override
  Widget build(BuildContext context) {
    // ColorTheme theme =
    //     (BlocProvider.of<TasksBloc>(context).state as TasksLoadSuccess)
    //         .theme
    //         .colorTheme;
    final theme = context.select<TasksBloc, ColorTheme>((bloc) =>
        bloc.state is TasksLoadSuccess
            ? (bloc.state as TasksLoadSuccess).theme.colorTheme
            : ColorThemeOption.theme1.colorTheme);
    if (!initialized) {
      setupListOfPriorityRadios(widget.initialSelected, theme);
      initialized = true;
    }
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        if (!initialized) {
          setupListOfPriorityRadios(widget.initialSelected, theme);
          initialized = true;
        }
        return SizedBox(
          width: 240,
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemCount: priorityRadios.length,
            itemBuilder: (context, index) {
              return IconButton(
                splashRadius: 0.1,
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
                icon: new PriorityRadioIcon(priorityRadios[index]),
              );
            },
          ),
        );
      },
    );
  }

  void setupListOfPriorityRadios(Priority selected, ColorTheme theme) {
    this.priorityRadios = [];
    final highPriorityRadio = PriorityRadio(false, '1', theme.high);
    final medHighPriorityRadio = PriorityRadio(false, '2', theme.medHigh);
    final medPriorityRadio = PriorityRadio(false, '3', theme.med);
    final lowMedPriorityRadio = PriorityRadio(false, '4', theme.lowMed);
    final lowPriorityRadio = PriorityRadio(false, '5', theme.low);

    switch (selected) {
      case Priority.low:
        priorityRadios.add(highPriorityRadio);
        priorityRadios.add(medHighPriorityRadio);
        priorityRadios.add(medPriorityRadio);
        priorityRadios.add(lowMedPriorityRadio);
        priorityRadios.add(PriorityRadio(true, '5', theme.low));
        break;
      case Priority.low_med:
        priorityRadios.add(highPriorityRadio);
        priorityRadios.add(medHighPriorityRadio);
        priorityRadios.add(medPriorityRadio);
        priorityRadios.add(PriorityRadio(true, '4', theme.lowMed));
        priorityRadios.add(lowPriorityRadio);
        break;
      case Priority.med:
        priorityRadios.add(highPriorityRadio);
        priorityRadios.add(medHighPriorityRadio);
        priorityRadios.add(PriorityRadio(true, '3', theme.med));
        priorityRadios.add(lowMedPriorityRadio);
        priorityRadios.add(lowPriorityRadio);
        break;
      case Priority.med_high:
        priorityRadios.add(highPriorityRadio);
        priorityRadios.add(PriorityRadio(true, '2', theme.medHigh));
        priorityRadios.add(medPriorityRadio);
        priorityRadios.add(lowMedPriorityRadio);
        priorityRadios.add(lowPriorityRadio);
        break;
      case Priority.high:
        priorityRadios.add(PriorityRadio(true, '1', theme.high));
        priorityRadios.add(medHighPriorityRadio);
        priorityRadios.add(medPriorityRadio);
        priorityRadios.add(lowMedPriorityRadio);
        priorityRadios.add(lowPriorityRadio);
        break;
    }
  }
}
