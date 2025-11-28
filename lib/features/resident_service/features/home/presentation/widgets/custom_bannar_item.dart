import 'package:flutter/material.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/responsive/size_config.dart';

class CustomBannarItem extends StatelessWidget {
  const CustomBannarItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: SizeConfig.screenWidth / 2.5,
          child: Padding(
            padding: context.isArabic
                ? const EdgeInsets.only(right: 20)
                : const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '30%',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Today's Special",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  "get discount on your first order",
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall!.copyWith(color: AppColors.whiteColor),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          width: 200,
          height: 170,
          right: context.isArabic ? null : -30,
          left: context.isArabic ? -30 : null,
          child: Image.asset(Assets.assetsImagesTest, fit: BoxFit.cover),
        ),
      ],
    );
  }
}
