import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/custom_doc_list_item_desc.dart';

class DoctorListItem extends StatelessWidget {
  const DoctorListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
      ),

      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDocImage(),
            const SizedBox(width: 18),
            Expanded(child: DoctorListItemDescriptionWidget()),
          ],
        ),
      ),
    );
  }

  AspectRatio _buildDocImage() {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.gray.withOpacity(0.3),
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(image: AssetImage(Assets.assetsImagesTest)),
        ),
      ),
    );
  }
}
