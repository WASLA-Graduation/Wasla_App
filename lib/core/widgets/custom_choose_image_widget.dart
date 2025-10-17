

import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/utils/size_config.dart';
import 'package:wasla/core/widgets/custom_get_image_source_widget.dart';

class CustomChooseImageWidget extends StatelessWidget {
  const CustomChooseImageWidget({
    super.key,
    required this.cameraOnPressed,
    required this.galaryOnPressed,
  });
  final VoidCallback cameraOnPressed;
  final VoidCallback galaryOnPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: SizeConfig.blockHeight * 26,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          VerticalSpace(height: 2),
          Text(
            "Choose Image",
            style: TextStyle(color: AppColors.blackColor, fontSize: 20,fontWeight: FontWeight.bold),
          ),
          VerticalSpace(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetImageSourceWidget(
                image: Assets.assetsImagesCamera,
                onPressed: cameraOnPressed,
              ),
              const HorizontilSpace(width: 15),
              GetImageSourceWidget(
                image: Assets.assetsImagesGallery,
                onPressed: galaryOnPressed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
