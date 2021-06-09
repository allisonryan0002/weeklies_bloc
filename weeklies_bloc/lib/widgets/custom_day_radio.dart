import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/utility/utility.dart';

// Rounded box material element representing the [DayRadio] model
//
// Used in the [CustomDayRadio] widget
class DayRadioIcon extends StatelessWidget {
  final DayRadio model;

  DayRadioIcon(this.model);

  @override
  Widget build(BuildContext context) {
    // [ColorTheme] to pull colors from
    final theme = BlocProvider.of<ThemeBloc>(context).state.theme.colorTheme;

    // Rounded box displaying the model.dayText
    return Container(
      child: Container(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            model.dayText,
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
          // Conditional border indicating the model's selection status
          border: model.isSelected
              ? Border.all(color: Colors.black.withOpacity(0.8), width: 1.3)
              : null,
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        padding: EdgeInsets.fromLTRB(5, 4, 5, 4),
      ),
      padding: EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: theme.med,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );
  }
}

// Smaller [DayRadioIcon] to fit on the [Task] [ListTile]s
//
// Only used on the [Task] [ListTile]s as buttons, not in the [CustomDayRadio]
// so they do not have conditional selection borders
class DayRadioIconTileSize extends StatelessWidget {
  final DayRadio item;

  DayRadioIconTileSize(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          item.dayText,
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

// Displays set of [DyRadioIcon]s in a horizontally wrapping list
class CustomDayRadio extends StatefulWidget {
  // Relays currently selected [Day](as int) to [TaskInputWidget]
  final Function(int) callback;

  // When [CustomDayRadio] is being built from an existing [Task], display
  // this [Day](as int) as the initially selected [DayRadioIcon]
  final int initialSelected;

  CustomDayRadio(this.callback, this.initialSelected);

  @override
  _CustomDayRadioState createState() => _CustomDayRadioState();
}

class _CustomDayRadioState extends State<CustomDayRadio> {
  // List of [DayRadio] models for the [DayRadioIcon]s to be built from
  late List<DayRadio> dayRadios = [];

  // Ordered list of days of the week based on the current day
  List<String> dayList = Day(DateTime.now().weekday).dayOptions;

  // Stores the selected [DayRadioIcon]s corresponding [Day](as int) value to
  // be passed into the callback function upon [Task] creation
  late int day;

  // Setup dayRadios list with [DayRadio]s based on the initialSelected
  @override
  void initState() {
    super.initState();
    dayRadios = generateDayRadioList(widget.initialSelected);
  }

  // [SizedBox] containing [DayRadioIcon] buttons wrapped horizontally
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
                child: DayRadioIcon(dayRadios[i]),
                padding: EdgeInsets.all(2),
              ),
              // Ensure only one button is selected at a time & rebuild to update
              onTap: () {
                setState(() {
                  dayRadios.forEach((element) {
                    element.isSelected = false;
                  });
                  dayRadios[i].isSelected = true;
                  day = dayList.indexOf(dayRadios[i].dayText);
                });
                widget.callback(day);
              },
            ),
        ],
      ),
    );
  }
}
