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

String getSectionTitle(DateTime date) {
  final now = DateTime.now();
  final diff = now.difference(date);

  if (diff.inDays == 0) {
    return "Today";
  } else if (diff.inDays == 1) {
    return "Yesterday";
  } else {
    return DateFormat('MMMM dd, yyyy').format(date);
  }
}

String formateDateToMatchWithPosts(DateTime date) {
  final DateTime now = DateTime.now();
  final diff = now.difference(date);

  if (diff.inMinutes < 60) {
    return "${diff.inMinutes} m";
  } else if (diff.inHours < 24) {
    return "${diff.inHours} h";
  } else if (diff.inDays == 1) {
    return "Yesterday";
  } else {
    return DateFormat('d MMM yyyy').format(date);
  }
}

String convertTimeToGoodFormat(TimeOfDay time) {
  final now = DateTime.now();

  final dateTime = DateTime(
    now.year,
    now.month,
    now.day,
    time.hour,
    time.minute,
    now.second,
  );

  return DateFormat('hh:mm:ss').format(dateTime);
}
