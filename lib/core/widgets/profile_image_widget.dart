import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/cached_network_image_widget.dart';

class ProfileImageWidget extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;

  const ProfileImageWidget({
    super.key,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          ClipOval(
            child: CustomCachedNetworkImage(
              imageUrl: imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorWidget: _buildErrorWidget(),
              loadingWidget: _buildLoadingWidget(),
            ),
          ),
          _buildEditWidget(),
        ],
      ),
    );
  }

  Container _buildLoadingWidget() {
    return Container(
              width: 100,
              height: 100,
              color: AppColors.grayDark.withOpacity(0.1),
            );
  }

  Container _buildErrorWidget() {
    return Container(
              width: 100,
              height: 100,
              color: AppColors.grayDark.withOpacity(0.1),
              child: Icon(
                Icons.error,
                color: AppColors.primaryColor,
                size: 40,
              ),
            );
  }

  Positioned _buildEditWidget() {
    return Positioned(
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(7),
        ),
        child: InkWell(
          onTap: onTap,
          child: Image.asset(
            Assets.assetsImagesEdit,
            height: 18,
            color: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}






//               placeholder: (context, url) => Container(
//                 width: 100,
//                 height: 100,
//                 color: AppColors.grayDark.withOpacity(0.1),
//               ),

//             