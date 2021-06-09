//
import 'package:weeklies/models/models.dart';

List<PriorityRadio> generatePriorityRadioList(Priority selected) {
  final highPriorityRadio = Priority.high.radio;
  final medHighPriorityRadio = Priority.med_high.radio;
  final medPriorityRadio = Priority.med.radio;
  final lowMedPriorityRadio = Priority.low_med.radio;
  final lowPriorityRadio = Priority.low.radio;

  switch (selected) {
    case Priority.low:
      return [
        highPriorityRadio,
        medHighPriorityRadio,
        medPriorityRadio,
        lowMedPriorityRadio,
        PriorityRadio(true, '5')
      ];
    case Priority.low_med:
      return [
        highPriorityRadio,
        medHighPriorityRadio,
        medPriorityRadio,
        PriorityRadio(true, '4'),
        lowPriorityRadio
      ];

    case Priority.med:
      return [
        highPriorityRadio,
        medHighPriorityRadio,
        PriorityRadio(true, '3'),
        lowMedPriorityRadio,
        lowPriorityRadio
      ];

    case Priority.med_high:
      return [
        highPriorityRadio,
        PriorityRadio(true, '2'),
        medPriorityRadio,
        lowMedPriorityRadio,
        lowPriorityRadio
      ];

    case Priority.high:
      return [
        PriorityRadio(true, '1'),
        medHighPriorityRadio,
        medPriorityRadio,
        lowMedPriorityRadio,
        lowPriorityRadio
      ];
  }
}
