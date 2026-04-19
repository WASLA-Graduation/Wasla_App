import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/utils/assets.dart';

class CustomProfilePicture extends StatelessWidget {
  const CustomProfilePicture({super.key, this.image, this.onPressed});
  final File? image;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: SizeConfig.screenWidth * 0.30,
          height: SizeConfig.screenWidth * 0.30,
          constraints: const BoxConstraints(maxHeight: 250, maxWidth: 250),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primaryColor, width: 2),
            image: image != null
                ? DecorationImage(image: FileImage(image!), fit: BoxFit.cover)
                : null,
          ),
          child: image == null
              ? Center(
                  child: Image.asset(
                    Assets.assetsImagesCameraPhoto,
                    width: SizeConfig.isTablet ? 80.w : 40.w,
                    height: SizeConfig.isTablet ? 120.h : 60.h,
                  ),
                )
              : null,
        ),

        Positioned(
          bottom: 0,
          right: SizeConfig.isTablet ? 25 : 0,
          child: CircleAvatar(
            radius: SizeConfig.isTablet ? 25 : 17,
            backgroundColor: AppColors.primaryColor,
            child: IconButton(
              padding: EdgeInsets.only(right: 0),
              onPressed: onPressed,
              icon: Icon(
                Icons.edit,
                color: AppColors.whiteColor,
                size: SizeConfig.isTablet ? 30 : 19,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
