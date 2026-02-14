import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/gym/features/packages/data/models/gym_package_model.dart';

class GymPackageItem extends StatelessWidget {
  const GymPackageItem({super.key, required this.model});
  final GymPackageModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0E0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Column(
            spacing: 7,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Center(child: CustomCachedNetworkImage(imageUrl: model.photoUrl)),
              Expanded(
                child: Transform.translate(
                  offset: Offset(0, -2),
                  child: Image.asset(Assets.assetsImagesGymTest),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    spacing: 4,

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        context.isArabic ? model.nameAr : model.nameEn,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        context.isArabic
                            ? model.descriptionAr
                            : model.descriptionEn,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Text(
                            "${model.price} ${"egb".tr(context)}",
                            style: Theme.of(context).textTheme.headlineSmall!
                                .copyWith(color: AppColors.primaryColor),
                          ),
                          const Spacer(),
                          Text(
                            "${model.durationInMonths} ${"months".tr(context)}",
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          model.precentage == 0
              ? const SizedBox()
              :
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
            ),

            child: Center(
              child: Text(
                "${model.precentage}%",
                style: TextStyle(fontSize: 12, color: AppColors.whiteColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
