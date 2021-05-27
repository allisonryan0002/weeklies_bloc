/* Computes the number of 'days' passed between prevTime and futTime
 * Days are in terms of the number of midnights within the time range
 * For example, between 11:59 and 12:01, one 'day' will be counted
 * Method used in taskList.dart
 */
dynamic dayDifference(DateTime prevTime, DateTime futTime) {
  // Map of months and their respective number of days
  Map<dynamic, dynamic> monthDays = {
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
  if (prevTime.day != futTime.day) {
    if (prevTime.month != futTime.month) {
      return ((-futTime.day) + (prevTime.day - monthDays[prevTime.month]));
    } else {
      return prevTime.day - futTime.day;
    }
  } else {
    return 0;
  }
}
