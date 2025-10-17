import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/utils/size_config.dart';

class CustomProfilePicture extends StatelessWidget {
  const CustomProfilePicture({super.key, this.image, this.onPressed});
  final File? image;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: SizeConfig.screenWidth * 0.15,
          backgroundImage: image == null
              ? AssetImage(Assets.assetsImagesMale)
              : FileImage(image!),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            radius: SizeConfig.blockWidth * 5,
            backgroundColor: AppColors.primaryColor,
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(Icons.edit, color: AppColors.whiteColor, size: 25),
            ),
          ),
        ),
      ],
    );
  }
}
