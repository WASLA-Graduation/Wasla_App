import 'package:flutter/material.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/cached_network_image_widget.dart';
import 'package:wasla/features/resident_service/features/doctor/data/models/doctor_data_model.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_details/custom_doc_text_details.dart';

class CustomDoctorDatailsCardWeiget extends StatelessWidget {
  const CustomDoctorDatailsCardWeiget({super.key, required this.doctor});
  final DoctorDataModel doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? AppColors.blackColor.withOpacity(0.1)
            : AppColors.whiteColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(tag: doctor.imageUrl, child: _buildDocImage()),
            const SizedBox(width: 18),
            Expanded(child: CustomDoctorDetailsText(doctor: doctor)),
          ],
        ),
      ),
    );
  }

  AspectRatio _buildDocImage() {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppColors.gray.withOpacity(0.3),
          borderRadius: BorderRadius.circular(15),
        ),

        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              width: 112,
              height: 112,
              child: CustomCachedNetworkImage(
                imageUrl: doctor.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
