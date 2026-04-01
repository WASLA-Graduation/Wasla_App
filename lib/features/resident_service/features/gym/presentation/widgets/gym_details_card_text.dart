import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/profile/data/models/gym_model.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_details/custom_doc_text_details.dart';

class GymDetailsCardText extends StatelessWidget {
  const GymDetailsCardText({super.key, required this.gym});
  final GymModel gym;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDoctorName(context),
        Divider(height: 15, color: AppColors.primaryColor, thickness: .1),
        CustomTextWithColonWidget(
          date: gym.ownerName,
          title: "owener".tr(context),
        ),
        const SizedBox(height: 3),
        CustomTextWithColonWidget(
          date: gym.businessName,
          title: "gymName".tr(context),
        ),
        const SizedBox(height: 3),
        CustomTextWithColonWidget(
          date: gym.phones.isEmpty ? '' : gym.phones[0],
          title: "phone".tr(context),
        ),
      ],
    );
  }

  Text _buildDoctorName(BuildContext context) {
    return Text(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      gym.businessName,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
