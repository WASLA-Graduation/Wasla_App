import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/doctor_service/features/service/data/models/doctor_service_model.dart';

class ResidentDoctorServiceItem extends StatelessWidget {
  const ResidentDoctorServiceItem({
    super.key,
    required this.doctorServiceModel,
  });

  final DoctorServiceModel doctorServiceModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  context.isArabic
                      ? doctorServiceModel.serviceNameArabic
                      : doctorServiceModel.serviceNameEnglish,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Text(
                "${doctorServiceModel.price.toString()} ${"egb".tr(context)}",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
            ],
          ),

          // Text(
          //   maxLines: 2,
          //   overflow: TextOverflow.ellipsis,
          //   _getDoctorServiceDays(context),
          //   style: Theme.of(
          //     context,
          //   ).textTheme.headlineMedium!.copyWith(color: AppColors.gray),
          // ),
        ],
      ),
    );
  }

  // String _getDoctorServiceDays(BuildContext context) {
  //   String days = "";
  //   for (var serviceDay in doctorServiceModel.serviceDays) {
  //     days += localizedDays(index: serviceDay.dayOfWeek).tr(context);
  //     if (serviceDay != doctorServiceModel.serviceDays.last) {
  //       days += " | ";
  //     }
  //   }
  //   return days;
  // }
}
