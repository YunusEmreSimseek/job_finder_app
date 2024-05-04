extension DateToStringExtension on DateTime {
  String toDateString() {
    return '$day-$month-$year';
  }

  String toAge() {
    final age = DateTime.now().year - year;
    return '$age';
  }
}
