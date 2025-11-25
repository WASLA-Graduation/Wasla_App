import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/manager/cubit/doctor_service_mangement_cubit.dart';

class DateTimelinePicker extends StatelessWidget {
  const DateTimelinePicker({super.key, required this.title, required this.initialSelectedDate});
  final String title;
  final DateTime initialSelectedDate;

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
          onDateChange: (date) {
            context.read<DoctorServiceMangementCubit>().selectedDate = date;
          },
        ),
      ],
    );
  }
}
