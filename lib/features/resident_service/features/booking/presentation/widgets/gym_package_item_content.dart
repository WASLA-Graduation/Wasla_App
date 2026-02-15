import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/gym/features/packages/data/models/gym_package_model.dart';

class PackageItemContent extends StatelessWidget {
  const PackageItemContent({super.key, required this.model});
  final GymPackageModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          context.isArabic ? model.nameAr : model.nameEn,
          style: Theme.of(context).textTheme.headlineMedium,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(),
        Text(
          context.isArabic ? model.descriptionAr : model.descriptionEn,
          style: Theme.of(context).textTheme.bodyMedium,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        model.precentage == 0
            ? FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "${model.price} ${"egb".tr(context)}",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              )
            : Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "${model.price} ${"egb".tr(context)} ",
                      style: Theme.of(context).textTheme.headlineSmall!
                          .copyWith(
                            color: AppColors.primaryColor,
                            decoration: TextDecoration.lineThrough,
                          ),
                    ),
                    TextSpan(
                      text: "${calculateFinalSalay()} ",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            "${model.durationInMonths} ${"months".tr(context)}",
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  String calculateFinalSalay() {
    double finalSalary = model.price - (model.price * (model.precentage / 100));
    return finalSalary.toString();
  }
}
