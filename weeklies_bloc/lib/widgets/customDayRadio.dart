import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weeklies/models/models.dart';

// Rounded box UI representing time selection options
class DayRadioIcon extends StatelessWidget {
  final DayRadio item;
  DayRadioIcon(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          item.timeText,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
              fontSize: 15,
              color: Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.w100),
          textAlign: TextAlign.center,
        ),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Color.fromRGBO(254, 203, 93, 1),
        boxShadow: item.isSelected
            ? [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 2,
                  spreadRadius: 1,
                  offset: Offset(1.5, 1.5),
                )
              ]
            : null,
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
      padding: EdgeInsets.fromLTRB(5, 4, 5, 4),
    );
  }
}

// Smaller DayRadioIcon to better fit in the task ListTiles
class DayRadioIconTileSize extends StatelessWidget {
  final DayRadio item;
  DayRadioIconTileSize(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          item.timeText,
          style: Theme.of(context).textTheme.subtitle1,
          textAlign: TextAlign.center,
        ),
      ),
      padding: EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
      decoration: BoxDecoration(
        color: Colors.grey.shade500,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
    );
  }
}

// Widget containing set of time radio buttons
class CustomDayRadio extends StatefulWidget {
  final Function(int) callback;

  CustomDayRadio(this.callback);
  @override
  _CustomDayRadioState createState() => _CustomDayRadioState();
}

class _CustomDayRadioState extends State<CustomDayRadio> {
  List<DayRadio> timeChoices = [];
  List<String> dayList = [];
  late int selectedTime;

  final currTime = DateTime.now().weekday;

  // 'Someday' time selected by default
  @override
  void initState() {
    super.initState();
    dayList = Day(currTime).dayOptions;
    for (String day in dayList.sublist(1, 8)) {
      timeChoices.add(DayRadio(false, day));
    }
    timeChoices.add(DayRadio(true, "Someday"));
    selectedTime = 8;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Wrap(
        children: [
          for (int i = 0; i < timeChoices.length; i++)
            GestureDetector(
              child: Container(
                padding: EdgeInsets.all(2),
                child: new DayRadioIcon(timeChoices[i]),
              ),
              onTap: () {
                setState(() {
                  timeChoices.forEach((element) {
                    element.isSelected = false;
                  });
                  timeChoices[i].isSelected = true;
                  selectedTime = dayList.indexOf(timeChoices[i].timeText);
                });
                widget.callback(selectedTime);
              },
            ),
        ],
      ),
    );
  }
}
