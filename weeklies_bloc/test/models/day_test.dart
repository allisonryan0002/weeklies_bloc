import 'package:flutter_test/flutter_test.dart';
import 'package:weeklies/models/models.dart';

void main() {
  group('Day', () {
    test('correctly generates day options given it is Monday', () {
      expect(Day(1).dayOptions, [
        'Overdue',
        'Today',
        'Tomorrow',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday',
        'Someday'
      ]);
    });

    test('throws error for invalid input integer', () {
      expect(() => Day(0), throwsArgumentError);
    });
  });
}
