extension DateWithTime on DateTime {
  DateTime withTime([int hour = 0, int minute = 0]) {
    return DateTime(this.year, this.month, this.day, hour, minute);
  }
}
