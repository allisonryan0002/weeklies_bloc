import 'package:flutter_test/flutter_test.dart';
import 'package:weeklies/models/models.dart';

void main() {
  group('Priority', () {
    test('radio is correctly assigned from getter method', () {
      final expectedRadio = PriorityRadio(radioNumText: '5', isSelected: false);
      final actualRadio = Priority.low.radio;
      expect(actualRadio is PriorityRadio, true);
      expect(actualRadio.isSelected, expectedRadio.isSelected);
      expect(actualRadio.radioNumText, expectedRadio.radioNumText);
    });

    test('comparison between low and high returns 1', () {
      expect(Priority.low.compareTo(Priority.high), 1);
    });

    test('comparison between low and low returns 1', () {
      expect(Priority.low.compareTo(Priority.low), 1);
    });

    test('comparison between high and low returns -1', () {
      expect(Priority.high.compareTo(Priority.low), -1);
    });

    test('comparison between low_med and med_high returns 1', () {
      expect(Priority.lowMed.compareTo(Priority.medHigh), 1);
    });

    test('comparison between med_high and low_med returns -1', () {
      expect(Priority.medHigh.compareTo(Priority.lowMed), -1);
    });

    test('toJson method produces 0 on Priority.low', () {
      expect(Priority.low.toJson(), 0);
    });

    test('fromJson method produces Priority.low from input 0', () {
      expect(PriorityExtension.fromJson(0), Priority.low);
    });

    test('fromJson method throws error for undefined input case', () {
      expect(() => PriorityExtension.fromJson(5), throwsArgumentError);
    });
  });
}
