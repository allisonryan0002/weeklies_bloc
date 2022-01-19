import 'package:weeklies/models/models.dart';

// Given the selected [Priority], generate [List<PriorityRadio>]
// reflecting the radio that is currently selected
List<PriorityRadio> generatePriorityRadioList(Priority selected) {
  // Unselected [PriorityRadio]s
  final highPriorityRadio = Priority.high.radio;
  final medHighPriorityRadio = Priority.medHigh.radio;
  final medPriorityRadio = Priority.med.radio;
  final lowMedPriorityRadio = Priority.lowMed.radio;
  final lowPriorityRadio = Priority.low.radio;

  // Return selected [PriorityRadio] with other unselected radios
  switch (selected) {
    case Priority.low:
      return [
        highPriorityRadio,
        medHighPriorityRadio,
        medPriorityRadio,
        lowMedPriorityRadio,
        PriorityRadio(radioNumText: '5', isSelected: true)
      ];
    case Priority.lowMed:
      return [
        highPriorityRadio,
        medHighPriorityRadio,
        medPriorityRadio,
        PriorityRadio(radioNumText: '4', isSelected: true),
        lowPriorityRadio
      ];

    case Priority.med:
      return [
        highPriorityRadio,
        medHighPriorityRadio,
        PriorityRadio(radioNumText: '3', isSelected: true),
        lowMedPriorityRadio,
        lowPriorityRadio
      ];

    case Priority.medHigh:
      return [
        highPriorityRadio,
        PriorityRadio(radioNumText: '2', isSelected: true),
        medPriorityRadio,
        lowMedPriorityRadio,
        lowPriorityRadio
      ];

    case Priority.high:
      return [
        PriorityRadio(radioNumText: '1', isSelected: true),
        medHighPriorityRadio,
        medPriorityRadio,
        lowMedPriorityRadio,
        lowPriorityRadio
      ];
  }
}
