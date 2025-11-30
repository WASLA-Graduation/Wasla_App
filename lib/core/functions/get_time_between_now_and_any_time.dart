DateTime getNextDayFromZeroIndex(int dayIndex) {
  const mapping = {
    0: DateTime.saturday,
    1: DateTime.sunday,
    2: DateTime.monday,
    3: DateTime.tuesday,
    4: DateTime.wednesday,
    5: DateTime.thursday,
    6: DateTime.friday,
  };

  final targetWeekday = mapping[dayIndex]!;
  final now = DateTime.now();

  int diff = (targetWeekday - now.weekday) % 7;
  if (diff <= 0) diff += 7;

  return now.add(Duration(days: diff));
}
