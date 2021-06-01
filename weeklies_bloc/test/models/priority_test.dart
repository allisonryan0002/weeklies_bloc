import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:weeklies/models/models.dart';

void main() {
  group('Priority', () {
    //TODO: Find better way for testing case below...
    test('radio is correctly assigned from getter method', () {
      final matcherRadio =
          PriorityRadio(false, '5', Color.fromRGBO(86, 141, 172, 1));
      expect(Priority.low.radio is PriorityRadio, true);
      expect(Priority.low.radio.isSelected, matcherRadio.isSelected);
      expect(Priority.low.radio.color, matcherRadio.color);
      expect(Priority.low.radio.radioNumText, matcherRadio.radioNumText);
    });

    test('color is correctly given from getter method', () {
      expect(Priority.low.color, Color.fromRGBO(86, 141, 172, 1));
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
      expect(Priority.low_med.compareTo(Priority.med_high), 1);
    });

    test('comparison between med_high and low_med returns -1', () {
      expect(Priority.med_high.compareTo(Priority.low_med), -1);
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
