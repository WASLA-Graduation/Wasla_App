import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/technician_booking_status.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_details/custom_doc_text_details.dart';
import 'package:wasla/features/technicant/features/home/data/models/technician_model.dart';

class ResidentTechDetailsCardText extends StatelessWidget {
  const ResidentTechDetailsCardText({super.key, required this.technical});
  final TechnicianModel technical;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDoctorName(context),
        Divider(height: 15, color: AppColors.primaryColor, thickness: .1),
        CustomTextWithColonWidget(
          date: TechnicianBookingStatus.getTitle(
            index: technical.specialty - 1,
          ).tr(context),
          title: "specialty".tr(context),
        ),
        const SizedBox(height: 3),
        CustomTextWithColonWidget(
          date: technical.experienceYears.toString(),
          title: "yearaExperience".tr(context),
        ),
        const SizedBox(height: 3),
        CustomTextWithColonWidget(
          date: technical.phone,
          title: "phone".tr(context),
        ),
      ],
    );
  }

  Text _buildDoctorName(BuildContext context) {
    return Text(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      technical.fullName,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
