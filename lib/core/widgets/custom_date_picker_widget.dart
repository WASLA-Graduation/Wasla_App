import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class CustomDatePickerWidget extends StatelessWidget {
  const CustomDatePickerWidget({
    super.key,
    required this.currentDate,
    this.onDateChange,
  });

  final DateTime currentDate;
  final void Function(DateTime)? onDateChange;

  @override
  Widget build(BuildContext context) {
    return DatePicker(
      height: 100,
      DateTime.now(),
      initialSelectedDate: currentDate,
      selectionColor: AppColors.primaryColor,
      selectedTextColor: Colors.white,
      onDateChange: onDateChange,
    );
  }
}
