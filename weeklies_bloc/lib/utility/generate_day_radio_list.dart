import 'package:weeklies/models/models.dart';

// Given the selected [Day](as int), generate [List<DayRadio>]
// reflecting the radio that is currently selected
List<DayRadio> generateDayRadioList(int selected) {
  // List to be filled out and returned
  List<DayRadio> dayRadios = [];
  // Get list of day options based on the current day - see [Day]
  List<String> dayList = Day(DateTime.now().weekday).dayOptions;
  // For selected day 0 (Overdue), give all future day options
  // 'Overdue' is never available to be selected, only occurs when a [Task]
  // is not completed on time
  if (selected == 0) {
    for (String day in dayList.sublist(1, 9)) {
      dayRadios.add(DayRadio(false, day));
    }
  }
  // For selected day 1 through 7 (days of the week), give selected option & all
  // others are unselected
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
  // For selected day 8 (Someday), give all days of the week as unselected &
  // give 'Someday' as selected
  if (selected == 8) {
    for (String day in dayList.sublist(1, 8)) {
      dayRadios.add(DayRadio(false, day));
    }
    dayRadios.add(DayRadio(true, "Someday"));
  }

  return dayRadios;
}
