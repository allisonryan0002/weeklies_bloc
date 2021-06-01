class Day {
  /* List of possible time choices based on the current day
   * There are 9 options, listed with their indices below:
   * 0 = Overdue, 1 = Today, Tomorrow = 2, (3-7) = other days (in their
   * respective order), 8 = Someday
   */
  List<String> dayOptions = ['Overdue', 'Today', 'Tomorrow'];

  // Select the days options based on the current day
  Day(int currDay) {
    List<String> daysToAdd = [];
    switch (currDay) {
      case 1: //Monday
        daysToAdd = ['Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
        break;
      case 2: //Tuesday
        daysToAdd = ['Thursday', 'Friday', 'Saturday', 'Sunday', 'Monday'];
        break;
      case 3: //Wednesday
        daysToAdd = ['Friday', 'Saturday', 'Sunday', 'Monday', 'Tuesday'];
        break;
      case 4: //Thursday
        daysToAdd = ['Saturday', 'Sunday', 'Monday', 'Tuesday', 'Wednesday'];
        break;
      case 5: //Friday
        daysToAdd = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday'];
        break;
      case 6: //Saturday
        daysToAdd = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
        break;
      case 7: //Sunday
        daysToAdd = ['Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
        break;
      default:
        throw ArgumentError('Invalid int option for a day of the week');
    }
    dayOptions.addAll(daysToAdd);
    dayOptions.add('Someday');
  }
}
