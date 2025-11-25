import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/localizedDays.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/doctor_service/features/service/data/models/doctor_service_model.dart';

class DoctorDaysList extends StatelessWidget {
  DoctorDaysList({super.key, required this.serviceDay});
  final List<ServiceDay> serviceDay;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(serviceDay.length, (index) {
        return Container(
          margin: const EdgeInsets.only(right: 7),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: ShapeDecoration(
            shape: StadiumBorder(),
            color: colors[index].withOpacity(0.1),
          ),
          child: Text(
            localizedDays(index: serviceDay[index].dayOfWeek).tr(context),
            style: Theme.of(
              context,
            ).textTheme.displaySmall!.copyWith(color: colors[index]),
          ),
        );
      }),
    );
  }

  final List<Color> colors = [
    AppColors.green,
    AppColors.blue,
    AppColors.orange,
    AppColors.red,
    AppColors.purple,
    AppColors.green,
    AppColors.blue,
    AppColors.orange,
    AppColors.red,
    AppColors.purple,
  ];
}
