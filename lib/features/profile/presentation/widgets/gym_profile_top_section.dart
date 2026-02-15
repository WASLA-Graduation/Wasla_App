import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/cached_network_image_widget.dart';
import 'package:wasla/features/profile/data/models/gym_model.dart';

class GymProfileTopSection extends StatelessWidget {
  const GymProfileTopSection({
    super.key,
    required this.gym,
  });

  final GymModel gym;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Row(
        spacing: 20,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CustomCachedNetworkImage(
              imageUrl: gym.profilePhoto,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
      
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  gym.businessName,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${'owener'.tr(context)}: ${gym.ownerName}',
                style: Theme.of(context).textTheme.headlineMedium!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
