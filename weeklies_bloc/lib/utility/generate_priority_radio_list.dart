import 'package:weeklies/models/models.dart';

// Given the selected [Priority], generate [List<PriorityRadio>]
// reflecting the radio that is currently selected
List<PriorityRadio> generatePriorityRadioList(Priority selected) {
  // Unselected [PriorityRadio]s
  final highPriorityRadio = Priority.high.radio;
  final medHighPriorityRadio = Priority.med_high.radio;
  final medPriorityRadio = Priority.med.radio;
  final lowMedPriorityRadio = Priority.low_med.radio;
  final lowPriorityRadio = Priority.low.radio;

  // Return selected [PriorityRadio] with other unselected radios
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
