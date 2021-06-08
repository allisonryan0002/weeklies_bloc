import 'package:weeklies/models/models.dart';

class PriorityRadio {
  bool isSelected;
  String radioNumText;

  PriorityRadio(this.isSelected, this.radioNumText);

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
