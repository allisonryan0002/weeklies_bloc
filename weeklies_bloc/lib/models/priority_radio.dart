import 'package:weeklies/models/models.dart';

// Model for [PriorityRadioIcon]
class PriorityRadio {
  PriorityRadio({required this.radioNumText, required this.isSelected});

  // Indicates if this [PriorityRadio] is the currently selected radio
  bool isSelected;
  // The number to be listed on the radio - can be 1 through 5
  String radioNumText;

  // Convenience getter to translate radioNumText into a [Priority] value
  Priority get priority {
    switch (radioNumText) {
      case '1':
        return Priority.high;
      case '2':
        return Priority.medHigh;
      case '3':
        return Priority.med;
      case '4':
        return Priority.lowMed;
      case '5':
        return Priority.low;
      default:
        return throw ArgumentError('Invalid radio text');
    }
  }
}
