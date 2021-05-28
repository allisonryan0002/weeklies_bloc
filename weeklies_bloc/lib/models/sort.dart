enum SortType { priority, time }

extension SortTypeExtension on SortType {
  int toJson() {
    switch (this) {
      case SortType.priority:
        return 0;
      case SortType.time:
        return 1;
    }
  }

  SortType fromJson(int val) {
    switch (val) {
      case 0:
        return SortType.priority;
      case 1:
        return SortType.time;
      default:
        return SortType.priority;
    }
  }
}
