class ItemTime {
  /* List of possible time choices based on the current day
   * There are 9 options, listed with their indices below:
   * 0 = Overdue, 1 = Today, Tomorrow = 2, (3-7) = other days (in their
   * respective order), 8 = Someday
   */
  List<String> timeOptions = ["Overdue", "Today", "Tomorrow"];

  // Select the days options based on the current day
  ItemTime(int currTime) {
    List<String> daysToAdd = [];
    switch (currTime) {
      case 1:
        daysToAdd = ["Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
        break;
      case 2:
        daysToAdd = ["Thursday", "Friday", "Saturday", "Sunday", "Monday"];
        break;
      case 3:
        daysToAdd = ["Friday", "Saturday", "Sunday", "Monday", "Tuesday"];
        break;
      case 4:
        daysToAdd = ["Saturday", "Sunday", "Monday", "Tuesday", "Wednesday"];
        break;
      case 5:
        daysToAdd = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday"];
        break;
      case 6:
        daysToAdd = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];
        break;
      case 7:
        daysToAdd = ["Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
    }
    timeOptions.addAll(daysToAdd);
    timeOptions.add("Someday");
  }
}
