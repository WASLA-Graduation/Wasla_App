import 'package:flutter/material.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';

class CustomMoreAppBarWidget extends StatelessWidget {
  const CustomMoreAppBarWidget({super.key, this.rightPadding});
  final double? rightPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.isArabic
          ? EdgeInsets.only(left: rightPadding ?? 20)
          : EdgeInsets.only(right: rightPadding ?? 20),
      child: Image.asset(
        Assets.assetsImagesMore,
        width: 21,
        color: context.isDarkMode ? AppColors.whiteColor : AppColors.blackColor,
      ),
    );
  }
}
