import 'package:weeklies/models/models.dart';

List<DayRadio> generateDayRadioList(int selected) {
  List<DayRadio> dayRadios = [];
  List<String> dayList = Day(DateTime.now().weekday).dayOptions;
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

  return dayRadios;
}
