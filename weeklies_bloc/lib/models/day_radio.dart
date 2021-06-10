// Model for [DayRadioIcon] & [DayRadioIconTileSize]
class DayRadio {
  // Indicates if this [DayRadio] is the currently selected radio
  bool isSelected;
  // The day to be listed on the radio - see [Day] for dayOptions
  String dayText;

  DayRadio(this.isSelected, this.dayText);
}
