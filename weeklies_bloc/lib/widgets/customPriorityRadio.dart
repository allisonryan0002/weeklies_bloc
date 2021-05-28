import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weeklies/models/models.dart';

// Priority radio model and its properties
class PriorityRadioModel {
  bool isSelected;
  String radioNumText;
  Color color;

  PriorityRadioModel(this.isSelected, this.radioNumText, this.color);
}

// Circular UI element representing the radio model
class PriorityRadioItem extends StatelessWidget {
  final PriorityRadioModel item;
  PriorityRadioItem(this.item);

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
  final Function(ItemPriority) callback;

  CustomPriorityRadio(this.callback);

  @override
  _CustomPriorityRadioState createState() => _CustomPriorityRadioState();
}

class _CustomPriorityRadioState extends State<CustomPriorityRadio> {
  List<PriorityRadioModel> priorityRadios = [];
  late ItemPriority priority;

  // Priority '3' selected by default
  @override
  void initState() {
    super.initState();
    priorityRadios.add(ItemPriority.high.radio);
    priorityRadios.add(ItemPriority.med_high.radio);
    priorityRadios
        .add(PriorityRadioModel(true, '3', Color.fromRGBO(254, 203, 93, 1)));
    priorityRadios.add(ItemPriority.low_med.radio);
    priorityRadios.add(ItemPriority.low.radio);
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
                priority = ItemPriority.values[index];
              });
              widget.callback(priority);
            },
            icon: new PriorityRadioItem(priorityRadios[index]),
          );
        },
      ),
    );
  }
}
