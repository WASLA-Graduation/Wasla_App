import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class DateTimelinePicker extends StatelessWidget {
  const DateTimelinePicker({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 12),
        DatePicker(
          height: 90,
          DateTime.now(),
          initialSelectedDate: DateTime.now(),
          selectionColor: AppColors.primaryColor,
          selectedTextColor: Colors.white,
          width: 60,
          onDateChange: (date) {},
        ),
      ],
    );
  }
}
