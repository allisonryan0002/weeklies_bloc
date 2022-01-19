// Computes the number of 'days' passed between prevTime and currTime
//
// Days are in terms of the number of midnights within the time range
// For example, between 11:59 PM and 12:01 AM, one 'day' will be counted
int adjustedDay(DateTime prevTime, DateTime currTime, int day) {
  // Map of months and their respective number of days
  const daysInMonth = <int, int>{
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
  int calculatedDay;
  // When the day is Someday, return Someday
  if (day == 8) {
    return day;
  }
  // If the day has changed
  if (prevTime.day != currTime.day) {
    // Calculation taking month changes into account
    if (prevTime.month != currTime.month) {
      final daysInPreviousMonth = daysInMonth[prevTime.month];
      calculatedDay =
          day + ((-currTime.day) + (prevTime.day - daysInPreviousMonth!));
      return (calculatedDay > 0) ? calculatedDay : 0;
    } else {
      // Calculation within the same month
      calculatedDay = day + prevTime.day - currTime.day;
      return (calculatedDay > 0) ? calculatedDay : 0;
    }
  } else {
    // If the day has not changed
    return day;
  }
}
