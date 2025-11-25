import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/format_date_from_string.dart';
import 'package:wasla/core/functions/format_time_with_intl.dart';
import 'package:wasla/features/doctor_service/features/service/data/models/doctor_service_model.dart';

class DoctorTimesWidget extends StatelessWidget {
  const DoctorTimesWidget({
    super.key,
    required this.serviceDates,
    required this.timeSlots,
  });
  final List<ServiceDate> serviceDates;
  final List<TimeSlot> timeSlots;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          getTimeAndDate(context),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }

  String getTimeAndDate(BuildContext context) {
    String res = '';
    serviceDates.forEach((date) {
      res += formatStringDate(date.date);
    });

    return "$res${convertBackendTimeToAmPm(timeSlots.first.start)} ${"to".tr(context)}  ${convertBackendTimeToAmPm(timeSlots.first.end)}";
  }
}
