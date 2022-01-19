import 'package:weeklies/models/models.dart';

// Given the selected [Day](as int), generate [List<DayRadio>]
// reflecting the radio that is currently selected
List<DayRadio> generateDayRadioList(int selected) {
  // List to be filled out and returned
  final dayRadios = <DayRadio>[];
  // Get list of day options based on the current day - see [Day]
  final dayList = Day(DateTime.now().weekday).dayOptions;
  // For selected day 0 (Overdue), give all future day options
  // 'Overdue' is never available to be selected, only occurs when a [Task]
  // is not completed on time
  if (selected == 0) {
    for (final day in dayList.sublist(1, 9)) {
      dayRadios.add(DayRadio(dayText: day, isSelected: false));
    }
  }
  // For selected day 1 through 7 (days of the week), give selected option & all
  // others are unselected
  if (selected < 8 && selected > 0) {
    for (var i = 1; i < 8; i++) {
      if (i == selected) {
        dayRadios.add(DayRadio(dayText: dayList[i], isSelected: true));
      } else {
        dayRadios.add(DayRadio(dayText: dayList[i], isSelected: false));
      }
    }
    dayRadios.add(DayRadio(dayText: 'Someday', isSelected: false));
  }
  // For selected day 8 (Someday), give all days of the week as unselected &
  // give 'Someday' as selected
  if (selected == 8) {
    for (final day in dayList.sublist(1, 8)) {
      dayRadios.add(DayRadio(dayText: day, isSelected: false));
    }
    dayRadios.add(DayRadio(dayText: 'Someday', isSelected: true));
  }

  return dayRadios;
}
