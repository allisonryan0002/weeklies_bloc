import 'package:flutter_test/flutter_test.dart';
import 'package:weeklies/utility/adjusted_day.dart';

void main() {
  group('DayDifference', () {
    test('returns 8 when the input day is 8 - i.e. Someday remains Someday',
        () {
      expect(adjustedDay(DateTime(2021, 6), DateTime(2021, 6), 8), 8);
    });
    test('returns 2 on input day 2 when the day hasnt changed', () {
      expect(adjustedDay(DateTime(2021, 6), DateTime(2021, 6), 2), 2);
    });

    test('returns 1 on input day 2 when a day has passed in the same month',
        () {
      expect(adjustedDay(DateTime(2021, 6), DateTime(2021, 6, 2), 2), 1);
    });

    test(
        'returns 1 on input day 2 when a day has passed and the month has '
        'changed', () {
      expect(adjustedDay(DateTime(2021, 5, 31), DateTime(2021, 6), 2), 1);
    });

    test('returns 0 when the day adjustment is negative', () {
      expect(adjustedDay(DateTime(2021, 6), DateTime(2021, 6, 5), 2), 0);
    });
  });
}
