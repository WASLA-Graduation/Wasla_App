import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatTimeWithIntl(TimeOfDay time) {
  final now = DateTime.now();

  final date = DateTime(
    now.year,
    now.month,
    now.day,
    time.hour,
    time.minute,
  );

  return DateFormat('hh:mm a').format(date);
}
