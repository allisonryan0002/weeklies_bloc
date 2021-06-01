import 'package:flutter_test/flutter_test.dart';
import 'package:weeklies/models/models.dart';

void main() {
  group('SortType', () {
    test('toJson method produces 0 on SortType.priority', () {
      expect(SortType.priority.toJson(), 0);
    });

    test('fromJson method produces SortType.priority from input 0', () {
      expect(SortTypeExtension.fromJson(0), SortType.priority);
    });

    test('fromJson method throws error for undefined input case', () {
      expect(() => SortTypeExtension.fromJson(2), throwsArgumentError);
    });
  });
}
