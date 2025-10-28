import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/size_config.dart';

abstract class AppStyles {
  static TextStyle bigDesdcriptionStyle = TextStyle(
    fontSize: SizeConfig.blockHeight * 4,
    fontWeight: FontWeight.bold,
    color: AppColors.blackColor,
  );
  static TextStyle smallDesdcriptionStyle = TextStyle(
    color: AppColors.gray,
    fontWeight: FontWeight.bold,
    fontSize: SizeConfig.textSize * 2,
  );
  static TextStyle meduimLableStyle = TextStyle(
    color: AppColors.blackColor,
    fontWeight: FontWeight.bold,
    fontSize: SizeConfig.textSize * 2.1,
  );
  static TextStyle smalTextStyle16Bold = TextStyle(
    color: AppColors.blackColor,
    fontWeight: FontWeight.bold,
    fontSize: SizeConfig.textSize * 2.2,
  );
  static TextStyle smalTextStyle13Bold = TextStyle(
    color: AppColors.gray,
    fontWeight: FontWeight.bold,
    fontSize: SizeConfig.textSize * 1.6,
  );
  static TextStyle meduimTextStyle20Bold = TextStyle(
    color: AppColors.blackColor,
    fontWeight: FontWeight.bold,
    fontSize: SizeConfig.textSize * 1.6,
  );
}
