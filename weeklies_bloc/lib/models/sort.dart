enum SortType { priority, day }

extension SortTypeExtension on SortType {
  int toJson() {
    switch (this) {
      case SortType.priority:
        return 0;
      case SortType.day:
        return 1;
    }
  }

  static SortType fromJson(int val) {
    switch (val) {
      case 0:
        return SortType.priority;
      case 1:
        return SortType.day;
      default:
        return throw ArgumentError('Invalid int value for a SortType');
    }
  }
}
