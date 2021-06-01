import 'package:flutter/material.dart';
import 'package:weeklies/models/models.dart';

enum Priority { high, med_high, med, low_med, low }

// Produces a radio model corresponding with the ItemPriority
extension PriorityExtension on Priority {
  PriorityRadio get radio {
    switch (this) {
      case Priority.low:
        return new PriorityRadio(false, '5', Color.fromRGBO(86, 141, 172, 1));
      case Priority.low_med:
        return new PriorityRadio(false, '4', Color.fromRGBO(152, 196, 209, 1));
      case Priority.med:
        return new PriorityRadio(false, '3', Color.fromRGBO(254, 203, 93, 1));
      case Priority.med_high:
        return new PriorityRadio(false, '2', Color.fromRGBO(250, 164, 91, 1));
      case Priority.high:
        return new PriorityRadio(false, '1', Color.fromRGBO(225, 113, 76, 1));
    }
  }

  Color get color {
    switch (this) {
      case Priority.low:
        return Color.fromRGBO(86, 141, 172, 1);
      case Priority.low_med:
        return Color.fromRGBO(152, 196, 209, 1);
      case Priority.med:
        return Color.fromRGBO(254, 203, 93, 1);
      case Priority.med_high:
        return Color.fromRGBO(250, 164, 91, 1);
      case Priority.high:
        return Color.fromRGBO(225, 113, 76, 1);
    }
  }

  int compareTo(Priority other) {
    switch (this) {
      case Priority.low:
        return 1;
      case Priority.low_med:
        int ret;
        if (other == Priority.low) {
          ret = -1;
        } else {
          ret = 1;
        }
        return ret;
      case Priority.med:
        int ret;
        if (other == Priority.low || other == Priority.low_med) {
          ret = -1;
        } else {
          ret = 1;
        }
        return ret;
      case Priority.med_high:
        int ret;
        if (other == Priority.high) {
          ret = 1;
        } else {
          ret = -1;
        }
        return ret;
      case Priority.high:
        return -1;
      default:
        return 0;
    }
  }

  // Conversion functions to and from JSON

  int toJson() {
    switch (this) {
      case Priority.low:
        return 0;
      case Priority.low_med:
        return 1;
      case Priority.med:
        return 2;
      case Priority.med_high:
        return 3;
      case Priority.high:
        return 4;
    }
  }

  static Priority fromJson(int val) {
    switch (val) {
      case 0:
        return Priority.low;
      case 1:
        return Priority.low_med;
      case 2:
        return Priority.med;
      case 3:
        return Priority.med_high;
      case 4:
        return Priority.high;
      default:
        return throw ArgumentError('Invalid int value for a priority');
    }
  }
}
