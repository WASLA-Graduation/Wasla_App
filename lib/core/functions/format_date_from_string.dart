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