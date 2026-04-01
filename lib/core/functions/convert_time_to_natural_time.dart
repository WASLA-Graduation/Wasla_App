String convertTimeToNaturalTimer({required int sec}) {
  final int min = sec ~/ 60;
  final int sec2 = sec % 60;
  return '${min.toString().padLeft(2, '0')}:${sec2.toString().padLeft(2, '0')}';
}
