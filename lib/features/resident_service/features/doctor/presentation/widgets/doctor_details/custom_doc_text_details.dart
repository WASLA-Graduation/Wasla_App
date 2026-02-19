import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/resident_service/features/doctor/data/models/doctor_data_model.dart';

class CustomDoctorDetailsText extends StatelessWidget {
  const CustomDoctorDetailsText({super.key, required this.doctor});
  final DoctorDataModel doctor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDoctorName(context),
        Divider(height: 15, color: AppColors.primaryColor, thickness: .1),
        CustomTextWithColonWidget(
          date: doctor.hospitalname,
          title: "hospital".tr(context),
        ),
        const SizedBox(height: 3),
        CustomTextWithColonWidget(
          date: doctor.specialtyName,
          title: "specialty".tr(context),
        ),
        const SizedBox(height: 3),
        CustomTextWithColonWidget(
          date: doctor.phone,
          title: "phone".tr(context),
        ),
      ],
    );
  }

  Text _buildDoctorName(BuildContext context) {
    return Text(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      doctor.fullName,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class CustomTextWithColonWidget extends StatelessWidget {
  const CustomTextWithColonWidget({
    super.key,
    required this.date,
    required this.title,
  });

  final String date;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      "$title : $date",
      style: Theme.of(
        context,
      ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
    );
  }
}
