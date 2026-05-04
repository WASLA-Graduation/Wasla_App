import 'package:flutter/material.dart';
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

String formatTimeOfDay(TimeOfDay time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return "$hour:$minute:00";
}

String formatDateToCustomString(DateTime date) {
  final now = DateTime.now();
  final diff = now.difference(date);

  if (diff.inDays == 0) {
    //today
    return DateFormat('hh:mm a').format(date);
  } else if (diff.inDays == 1) {
    return 'Yesterday';
  } else if (diff.inDays < 7) {
    return DateFormat('EEEE').format(date); // Mon, Tue, etc.
  } else {
    return DateFormat('d MMM').format(date); // 10 May
  }
}

String formatDateBooking(DateTime date) {
  final day = DateFormat('dd').format(date);
  final month = DateFormat('MMM').format(date);
  final weekDay = DateFormat('EEE').format(date);

  return '$day $month | $weekDay';
}

String formatDateToNotificationString(DateTime date) {
  final now = DateTime.now();
  final diff = now.difference(date);

  if (diff.inMinutes < 1) {
    return 'just now';
  }

  if (diff.inMinutes < 60) {
    return '${diff.inMinutes}m ago';
  }

  if (diff.inHours < 24 && now.day == date.day) {
    return '${diff.inHours}h ago';
  }

  if (diff.inDays == 1 || now.difference(date).inHours < 48) {
    return 'Yesterday ${DateFormat('h:mm a').format(date)}';
  }

  if (diff.inDays < 7) {
    return DateFormat('EEEE').format(date);
  }

  return DateFormat('dd MMM').format(date);
}
