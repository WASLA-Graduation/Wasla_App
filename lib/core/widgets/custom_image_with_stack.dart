import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/cached_network_image_widget.dart';

class BuildImageWithStackWidget extends StatelessWidget {
  const BuildImageWithStackWidget({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        // width: 90,
        // height: 90,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppColors.gray.withOpacity(0.3),
          borderRadius: BorderRadius.circular(15),

          // image: DecorationImage(image: AssetImage(Assets.assetsImagesOnboardingTwo)),
        ),

        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              width: 112,
              height: 112,
              child: CustomCachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}