import 'package:flutter/material.dart';
import 'package:weeklies/models/models.dart';

/// Five custom priority levels for the [Task]s
enum Priority { high, medHigh, med, lowMed, low }

// Convenience extensions
extension PriorityExtension on Priority {
  // Get a radio model corresponding with the [Priority]
  PriorityRadio get radio {
    switch (this) {
      case Priority.low:
        return PriorityRadio(radioNumText: '5', isSelected: false);
      case Priority.lowMed:
        return PriorityRadio(radioNumText: '4', isSelected: false);
      case Priority.med:
        return PriorityRadio(radioNumText: '3', isSelected: false);
      case Priority.medHigh:
        return PriorityRadio(radioNumText: '2', isSelected: false);
      case Priority.high:
        return PriorityRadio(radioNumText: '1', isSelected: false);
    }
  }

  // Get the [ColorTheme] color corresponding to a [Priority] value
  Color color(ColorTheme theme) {
    switch (this) {
      case Priority.low:
        return theme.low;
      case Priority.lowMed:
        return theme.lowMed;
      case Priority.med:
        return theme.med;
      case Priority.medHigh:
        return theme.medHigh;
      case Priority.high:
        return theme.high;
    }
  }

  // Custom comparision function for sorting [Task]s by [Priority]
  int compareTo(Priority other) {
    switch (this) {
      case Priority.low:
        return 1;
      case Priority.lowMed:
        int ret;
        if (other == Priority.low) {
          ret = -1;
        } else {
          ret = 1;
        }
        return ret;
      case Priority.med:
        int ret;
        if (other == Priority.low || other == Priority.lowMed) {
          ret = -1;
        } else {
          ret = 1;
        }
        return ret;
      case Priority.medHigh:
        int ret;
        if (other == Priority.high) {
          ret = 1;
        } else {
          ret = -1;
        }
        return ret;
      case Priority.high:
        return -1;
    }
  }

  // Conversion functions to and from json
  int toJson() {
    switch (this) {
      case Priority.low:
        return 0;
      case Priority.lowMed:
        return 1;
      case Priority.med:
        return 2;
      case Priority.medHigh:
        return 3;
      case Priority.high:
        return 4;
    }
  }

  static Priority fromJson(dynamic val) {
    switch (val) {
      case 0:
        return Priority.low;
      case 1:
        return Priority.lowMed;
      case 2:
        return Priority.med;
      case 3:
        return Priority.medHigh;
      case 4:
        return Priority.high;
      default:
        return throw ArgumentError('Invalid int value for a priority');
    }
  }
}
