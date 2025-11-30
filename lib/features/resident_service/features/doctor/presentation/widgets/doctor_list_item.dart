import 'package:flutter/material.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/cached_network_image_widget.dart';
import 'package:wasla/features/resident_service/features/doctor/data/models/doctor_data_model.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/custom_doc_list_item_desc.dart';

class DoctorListItem extends StatelessWidget {
  const DoctorListItem({
    super.key,
    required this.index,
    this.withoutFav,
    required this.doctor,
  });
  final int index;
  final bool? withoutFav;
  final DoctorDataModel doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color:context.isDarkMode?AppColors.blackColor.withOpacity(0.2): AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
      ),

      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(tag: doctor.imageUrl, child: _buildDocImage()),
            const SizedBox(width: 18),
            Expanded(
              child: DoctorListItemDescriptionWidget(
                doctor: doctor,
                index: index,
                withoutFav: withoutFav,
              ),
            ),
          ],
        ),
      ),
    );
  }

  AspectRatio _buildDocImage() {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        // width: 90,
        // height: 90,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppColors.gray.withOpacity(0.3),
          borderRadius: BorderRadius.circular(15),

          // image: DecorationImage(image: AssetImage(Assets.assetsImagesOnboardingTwo)),
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
