/* Computes the number of 'days' passed between prevTime and futTime
 * Days are in terms of the number of midnights within the time range
 * For example, between 11:59 and 12:01, one 'day' will be counted
 * Method used in task.dart
 */
dynamic adjustedDay(DateTime prevTime, DateTime currTime, int day) {
  // Map of months and their respective number of days
  Map<dynamic, dynamic> daysInMonth = {
    1: 31,
    2: 28,
    3: 31,
    4: 30,
    5: 31,
    6: 30,
    7: 31,
    8: 31,
    9: 30,
    10: 31,
    11: 30,
    12: 31
  };
  // Compute days elapsed taking monthly day changes into account
  dynamic calculatedDay;
  // When the day is Someday, return Someday
  if (day == 8) {
    return day;
  }
  if (prevTime.day != currTime.day) {
    if (prevTime.month != currTime.month) {
      calculatedDay = day +
          ((-currTime.day) + (prevTime.day - daysInMonth[prevTime.month]));
      return (calculatedDay > 0) ? calculatedDay : 0;
    } else {
      calculatedDay = day + prevTime.day - currTime.day;
      return (calculatedDay > 0) ? calculatedDay : 0;
    }
  } else {
    return day;
  }
}
