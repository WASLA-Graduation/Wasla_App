import 'package:flutter/material.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/cached_network_image_widget.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/general_resident_bookings_model.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/widgets/booking_item_data.dart';

class ResidentBookItem extends StatelessWidget {
  const ResidentBookItem({super.key, required this.model, required this.index});
  final GeneralResidentBookingsModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? AppColors.blackColor.withOpacity(0.2)
            : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDocImage(),
          const SizedBox(width: 18),
          Expanded(
            child: BookingItemData(
              index: index,
              model: model,
              isUpcoming:
                  model.baseStatus == "upComing" ||
                  model.baseStatus == "active",
            ),
          ),
        ],
      ),
    );
  }

  Container _buildDocImage() {
    return Container(
      width: 90,
      height: 90,
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
              imageUrl: model.baseImage,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
