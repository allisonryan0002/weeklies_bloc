import 'package:weeklies/models/models.dart';

// Model for [PriorityRadioIcon]
class PriorityRadio {
  // Indicates if this [PriorityRadio] is the currently selected radio
  bool isSelected;
  // The number to be listed on the radio - can be 1 through 5
  String radioNumText;

  PriorityRadio(this.isSelected, this.radioNumText);

  // Convenience getter to translate radioNumText into a [Priority] value
  Priority get priority {
    switch (this.radioNumText) {
      case '1':
        return Priority.high;
      case '2':
        return Priority.med_high;
      case '3':
        return Priority.med;
      case '4':
        return Priority.low_med;
      case '5':
        return Priority.low;
      default:
        return throw ArgumentError('Invalid radio text');
    }
  }
}
