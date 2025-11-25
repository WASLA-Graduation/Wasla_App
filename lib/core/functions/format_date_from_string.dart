import 'package:intl/intl.dart';

String formatStringDate(String stringDate) {
  try {
    final date = DateTime.parse(stringDate);
    final day = date.day.toString();
    final month = DateFormat('MMM').format(date); // Nov

    return "$day $month | ";
  } catch (e) {
    return stringDate;
  }
}
