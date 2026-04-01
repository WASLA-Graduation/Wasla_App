import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/functions/format_time_with_intl.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/doctor_service/features/service/data/models/doctor_service_model.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/manager/cubit/doctor_service_mangement_cubit.dart';

class ShowTimeServiceWidget extends StatelessWidget {
  const ShowTimeServiceWidget({
    super.key,
    required this.doctorServiceModel,
  });
  final DoctorServiceModel doctorServiceModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      DoctorServiceMangementCubit,
      DoctorServiceMangementState
    >(
      builder: (context, state) {
        List<TimeSlotModel> slots = [];

        slots = doctorServiceModel.serviceDays.first.timeSlots;

        String time = _buildTime(slots);
        return Text(
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          time,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: AppColors.gray,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }

  String _buildTime(List<TimeSlotModel> timeSlotModel) {
    String time = '';
    for (var element in timeSlotModel) {
      time +=
          '${convertBackendTimeToAmPm(element.start)} - ${convertBackendTimeToAmPm(element.end)}';
      if (timeSlotModel.indexOf(element) != timeSlotModel.length - 1) {
        time += ' | ';
      }
    }
    return time;
  }
}
