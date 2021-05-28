import 'package:flutter/material.dart';
import 'package:weeklies/widgets/widgets.dart';

enum ItemPriority { high, med_high, med, low_med, low }

// Produces a radio model corresponding with the ItemPriority
extension ItemPriorityExtension on ItemPriority {
  PriorityRadioModel get radio {
    switch (this) {
      case ItemPriority.low:
        return new PriorityRadioModel(
            false, '5', Color.fromRGBO(86, 141, 172, 1));
      case ItemPriority.low_med:
        return new PriorityRadioModel(
            false, '4', Color.fromRGBO(152, 196, 209, 1));
      case ItemPriority.med:
        return new PriorityRadioModel(
            false, '3', Color.fromRGBO(254, 203, 93, 1));
      case ItemPriority.med_high:
        return new PriorityRadioModel(
            false, '2', Color.fromRGBO(250, 164, 91, 1));
      case ItemPriority.high:
        return new PriorityRadioModel(
            false, '1', Color.fromRGBO(225, 113, 76, 1));
    }
  }

  Color get color {
    switch (this) {
      case ItemPriority.low:
        return Color.fromRGBO(86, 141, 172, 1);
      case ItemPriority.low_med:
        return Color.fromRGBO(152, 196, 209, 1);
      case ItemPriority.med:
        return Color.fromRGBO(254, 203, 93, 1);
      case ItemPriority.med_high:
        return Color.fromRGBO(250, 164, 91, 1);
      case ItemPriority.high:
        return Color.fromRGBO(225, 113, 76, 1);
    }
  }

  int compareTo(ItemPriority other) {
    switch (this) {
      case ItemPriority.low:
        return 1;
      case ItemPriority.low_med:
        int ret;
        if (other == ItemPriority.low) {
          ret = -1;
        } else {
          ret = 1;
        }
        return ret;
      case ItemPriority.med:
        int ret;
        if (other == ItemPriority.low || other == ItemPriority.low_med) {
          ret = -1;
        } else {
          ret = 1;
        }
        return ret;
      case ItemPriority.med_high:
        int ret;
        if (other == ItemPriority.high) {
          ret = 1;
        } else {
          ret = -1;
        }
        return ret;
      case ItemPriority.high:
        return -1;
      default:
        return 0;
    }
  }

  // Conversion functions to and from JSON

  int toJson() {
    switch (this) {
      case ItemPriority.low:
        return 0;
      case ItemPriority.low_med:
        return 1;
      case ItemPriority.med:
        return 2;
      case ItemPriority.med_high:
        return 3;
      case ItemPriority.high:
        return 4;
      default:
        return 0;
    }
  }

  ItemPriority fromJson(int val) {
    switch (val) {
      case 0:
        return ItemPriority.low;
      case 1:
        return ItemPriority.low_med;
      case 2:
        return ItemPriority.med;
      case 3:
        return ItemPriority.med_high;
      case 4:
        return ItemPriority.high;
      default:
        return ItemPriority.low;
    }
  }
}
