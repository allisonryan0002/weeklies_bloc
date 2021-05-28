import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weeklies/models/models.dart';

// Time radio model and its properties
class TimeRadioModel {
  bool isSelected;
  String timeText;

  TimeRadioModel(this.isSelected, this.timeText);
}

// Rounded box UI representing time selection options
class TimeRadioItem extends StatelessWidget {
  final TimeRadioModel item;
  TimeRadioItem(this.item);

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

// Smaller TimeRadioItem to better fit in the task ListTiles
class TimeRadioItemTileSize extends StatelessWidget {
  final TimeRadioModel item;
  TimeRadioItemTileSize(this.item);

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
class CustomTimeRadio extends StatefulWidget {
  final Function(int) callback;

  CustomTimeRadio(this.callback);
  @override
  _CustomTimeRadioState createState() => _CustomTimeRadioState();
}

class _CustomTimeRadioState extends State<CustomTimeRadio> {
  List<TimeRadioModel> timeChoices = [];
  List<String> dayList = [];
  late int selectedTime;

  final currTime = DateTime.now().weekday;

  // 'Someday' time selected by default
  @override
  void initState() {
    super.initState();
    dayList = ItemTime(currTime).timeOptions;
    for (String day in dayList.sublist(1, 8)) {
      timeChoices.add(TimeRadioModel(false, day));
    }
    timeChoices.add(TimeRadioModel(true, "Someday"));
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
                child: new TimeRadioItem(timeChoices[i]),
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
