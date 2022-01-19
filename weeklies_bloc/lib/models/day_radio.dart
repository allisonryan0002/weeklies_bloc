// Model for [DayRadioIcon] & [DayRadioIconTileSize]
class DayRadio {
  DayRadio({required this.dayText, required this.isSelected});

  // Indicates if this [DayRadio] is the currently selected radio
  bool isSelected;
  // The day to be listed on the radio - see [Day] for dayOptions
  String dayText;
}
