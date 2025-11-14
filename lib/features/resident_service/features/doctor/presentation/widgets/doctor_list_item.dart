import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/custom_doc_list_item_desc.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_item_list_booking.dart';

class DoctorListItem extends StatelessWidget {
  const DoctorListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDocImage(),
          const SizedBox(width: 10),
          Expanded(child: DoctorListItemDescriptionWidget()),
          const SizedBox(width: 20),
          DoctorItemListBooking(),
        ],
      ),
    );
  }

  AspectRatio _buildDocImage() {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.gray.withOpacity(0.1),
          shape: BoxShape.circle,
          image: DecorationImage(image: AssetImage(Assets.assetsImagesTest)),
        ),
      ),
    );
  }
}
