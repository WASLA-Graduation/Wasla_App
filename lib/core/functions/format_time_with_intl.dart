import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatTimeWithIntl(TimeOfDay time) {
  final now = DateTime.now();

  final date = DateTime(now.year, now.month, now.day, time.hour, time.minute);

  return DateFormat('hh:mm a').format(date);
}

String formatDateTimeWithIntl(DateTime dateTime) {
  return DateFormat('hh:mm a').format(dateTime);
}

String convertBackendTimeToAmPm(String apiTime) {
  try {
    final parsedTime = DateFormat("HH:mm:ss").parse(apiTime);
    return DateFormat("h:mm a").format(parsedTime);
  } catch (e) {
    return apiTime;
  }
}

TimeOfDay convertStringToTimeOfDay(String apiTime) {
  try {
    final parsedTime = DateFormat("HH:mm:ss").parse(apiTime);
    return TimeOfDay(hour: parsedTime.hour, minute: parsedTime.minute);
  } catch (e) {
    return TimeOfDay(hour: 0, minute: 0);
  }
}

DateTime convertStringToDateTime(String apiTime) {
  try {
    final parsedTime = DateFormat("yyyy-MM-dd").parse(apiTime);
    return parsedTime;
  } catch (e) {
    return DateTime.now();
  }
}
