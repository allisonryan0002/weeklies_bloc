import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/models/models.dart';

// Rounded box UI representing time selection options
class DayRadioIcon extends StatelessWidget {
  final DayRadio item;
  DayRadioIcon(this.item);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        if (state is ThemeLoadSuccess) {
          final theme = state.theme.colorTheme;
          return Container(
            padding: EdgeInsets.all(1.5),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: theme.med,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Container(
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
                color: theme.med,
                border: item.isSelected
                    ? Border.all(color: Colors.black, width: 1.15)
                    : null,
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
              padding: EdgeInsets.fromLTRB(5, 4, 5, 4),
            ),
          );
        } else {
          //TODO: better wayt to address this
          return Container();
        }
      },
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
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(color: Colors.black.withOpacity(0.8)),
          textAlign: TextAlign.center,
        ),
      ),
      padding: EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
    );
  }
}

// Widget containing set of time radio buttons
class CustomDayRadio extends StatefulWidget {
  final Function(int) callback;
  final int initialSelected;

  CustomDayRadio(this.callback, this.initialSelected);
  @override
  _CustomDayRadioState createState() => _CustomDayRadioState();
}

class _CustomDayRadioState extends State<CustomDayRadio> {
  List<DayRadio> dayRadios = [];
  List<String> dayList = [];
  late int day;
  final currWeekday = DateTime.now().weekday;

  @override
  void initState() {
    super.initState();
    setupListOfDayRadios(widget.initialSelected);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        children: [
          for (int i = 0; i < dayRadios.length; i++)
            GestureDetector(
              child: Container(
                padding: EdgeInsets.all(2),
                child: new DayRadioIcon(dayRadios[i]),
              ),
              onTap: () {
                setState(() {
                  dayRadios.forEach((element) {
                    element.isSelected = false;
                  });
                  dayRadios[i].isSelected = true;
                  day = dayList.indexOf(dayRadios[i].timeText);
                });
                widget.callback(day);
              },
            ),
        ],
      ),
    );
  }

  void setupListOfDayRadios(int selected) {
    dayRadios = [];
    dayList = Day(currWeekday).dayOptions;
    if (selected == 0) {
      for (String day in dayList.sublist(1, 9)) {
        dayRadios.add(DayRadio(false, day));
      }
    }
    if (selected < 8 && selected > 0) {
      for (int i = 1; i < 8; i++) {
        if (i == selected) {
          dayRadios.add(DayRadio(true, dayList[i]));
        } else {
          dayRadios.add(DayRadio(false, dayList[i]));
        }
      }
      dayRadios.add(DayRadio(false, "Someday"));
    }
    if (selected == 8) {
      for (String day in dayList.sublist(1, 8)) {
        dayRadios.add(DayRadio(false, day));
      }
      dayRadios.add(DayRadio(true, "Someday"));
    }
  }
}
