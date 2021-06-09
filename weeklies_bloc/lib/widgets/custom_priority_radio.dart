import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/models/models.dart';

// Circular UI element representing the radio model
class PriorityRadioIcon extends StatelessWidget {
  final PriorityRadio item;
  PriorityRadioIcon(this.item);

  @override
  Widget build(BuildContext context) {
    final theme = BlocProvider.of<ThemeBloc>(context).state.theme.colorTheme;
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
          color: item.priority.color(theme),
        ),
        margin: EdgeInsets.all(2.5),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: item.isSelected
            ? Border.all(
                color: item.priority.color(theme),
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
  //bool initialized = false;

  @override
  void initState() {
    super.initState();
    setupListOfPriorityRadios(widget.initialSelected);
  }

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
  }

  void setupListOfPriorityRadios(Priority selected) {
    this.priorityRadios = [];
    final highPriorityRadio = Priority.high.radio;
    final medHighPriorityRadio = Priority.med_high.radio;
    final medPriorityRadio = Priority.med.radio;
    final lowMedPriorityRadio = Priority.low_med.radio;
    final lowPriorityRadio = Priority.low.radio;

    switch (selected) {
      case Priority.low:
        priorityRadios.add(highPriorityRadio);
        priorityRadios.add(medHighPriorityRadio);
        priorityRadios.add(medPriorityRadio);
        priorityRadios.add(lowMedPriorityRadio);
        priorityRadios.add(PriorityRadio(true, '5'));
        break;
      case Priority.low_med:
        priorityRadios.add(highPriorityRadio);
        priorityRadios.add(medHighPriorityRadio);
        priorityRadios.add(medPriorityRadio);
        priorityRadios.add(PriorityRadio(true, '4'));
        priorityRadios.add(lowPriorityRadio);
        break;
      case Priority.med:
        priorityRadios.add(highPriorityRadio);
        priorityRadios.add(medHighPriorityRadio);
        priorityRadios.add(PriorityRadio(true, '3'));
        priorityRadios.add(lowMedPriorityRadio);
        priorityRadios.add(lowPriorityRadio);
        break;
      case Priority.med_high:
        priorityRadios.add(highPriorityRadio);
        priorityRadios.add(PriorityRadio(true, '2'));
        priorityRadios.add(medPriorityRadio);
        priorityRadios.add(lowMedPriorityRadio);
        priorityRadios.add(lowPriorityRadio);
        break;
      case Priority.high:
        priorityRadios.add(PriorityRadio(true, '1'));
        priorityRadios.add(medHighPriorityRadio);
        priorityRadios.add(medPriorityRadio);
        priorityRadios.add(lowMedPriorityRadio);
        priorityRadios.add(lowPriorityRadio);
        break;
    }
  }
}
