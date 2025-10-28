import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/utils/size_config.dart';

class CustomBannarItem extends StatelessWidget {
  const CustomBannarItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: SizeConfig.screenWidth / 2.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '30%',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: AppColors.whiteColor
                ),
              ),
              Text(
                "Today's Special",
                style:Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.whiteColor
                ),
              ),
              SizedBox(height: 5),
              Text(
                "get discount on your first order",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: AppColors.whiteColor
                ),
              ),
            ],
          ),
        ),
        Positioned(
          width: 200,
          height: 170,
          right: -30,
          child: Image.asset(Assets.assetsImagesTest, fit: BoxFit.cover),
        ),
      ],
    );
  }
}
