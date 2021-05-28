import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

  CustomPriorityRadio(this.callback);

  @override
  _CustomPriorityRadioState createState() => _CustomPriorityRadioState();
}

class _CustomPriorityRadioState extends State<CustomPriorityRadio> {
  List<PriorityRadio> priorityRadios = [];
  late Priority priority;

  // Priority '3' selected by default
  @override
  void initState() {
    super.initState();
    priorityRadios.add(Priority.high.radio);
    priorityRadios.add(Priority.med_high.radio);
    priorityRadios
        .add(PriorityRadio(true, '3', Color.fromRGBO(254, 203, 93, 1)));
    priorityRadios.add(Priority.low_med.radio);
    priorityRadios.add(Priority.low.radio);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: priorityRadios.length,
        itemBuilder: (context, index) {
          return IconButton(
            splashRadius: 0.1,
            onPressed: () {
              setState(() {
                priorityRadios.forEach((element) {
                  element.isSelected = false;
                });
                priorityRadios[index].isSelected = true;
                priority = Priority.values[index];
              });
              widget.callback(priority);
            },
            icon: new PriorityRadioIcon(priorityRadios[index]),
          );
        },
      ),
    );
  }
}
