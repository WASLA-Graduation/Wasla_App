import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/doctor_service/features/service/data/models/doctor_service_model.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/manager/cubit/doctor_service_mangement_cubit.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/custom_choose_time_widget.dart';

class CustomChooseTimeDocServiceWidget extends StatefulWidget {
  const CustomChooseTimeDocServiceWidget({super.key, this.selectedTime});
  final TimeSlot? selectedTime;

  @override
  State<CustomChooseTimeDocServiceWidget> createState() =>
      _CustomChooseTimeDocServiceWidgetState();
}

class _CustomChooseTimeDocServiceWidgetState
    extends State<CustomChooseTimeDocServiceWidget> {
  @override
  void initState() {
    checkTimeSlot();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorServiceMangementCubit>();
    return BlocBuilder<
      DoctorServiceMangementCubit,
      DoctorServiceMangementState
    >(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: CustomChooseTimeWidget(
                text: 'from'.tr(context),
                dateChange: (fromTime) {
                  cubit.upadteTimeFrom(time: fromTime);
                },
                selectedTime: cubit.timeFrom,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomChooseTimeWidget(
                text: 'to'.tr(context),
                dateChange: (toTime) {
                  cubit.upadteTimeTo(time: toTime);
                },
                selectedTime: cubit.timeTo,
              ),
            ),
          ],
        );
      },
    );
  }

  void checkTimeSlot() {
    final cubit = context.read<DoctorServiceMangementCubit>();

    if (widget.selectedTime != null) {
      cubit.upadteTimeTo(time: parseTimeOfDay(widget.selectedTime!.end));
      cubit.upadteTimeFrom(time: parseTimeOfDay(widget.selectedTime!.start));
    }
  }

  TimeOfDay parseTimeOfDay(String timeString) {
    List<String> parts = timeString.split(":");
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }
}
