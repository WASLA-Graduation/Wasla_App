import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:wasla/core/extensions/config_extension.dart';
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
      dateTextStyle: _buildStyle(context,20),
      dayTextStyle: _buildStyle(context,12),
      monthTextStyle: _buildStyle(context,12),

      onDateChange: onDateChange,
    );
  }

  TextStyle _buildStyle(BuildContext context,double  fontSize) {
    return TextStyle(
      fontSize: fontSize,
      color: context.isDarkMode ? Colors.white : Colors.black,
    );
  }
}
