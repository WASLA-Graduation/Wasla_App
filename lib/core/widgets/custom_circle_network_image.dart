import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wasla/core/widgets/cached_network_image_widget.dart';

class CircleNeworkImage extends StatelessWidget {
  const CircleNeworkImage({
    super.key,
    required this.imageUrl,
    this.onTap,
    required this.isLoading,
    this.size = 44,
  });

  final String imageUrl;
  final VoidCallback? onTap;
  final bool isLoading;

  final double? size;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Skeletonizer(
            child: CircleAvatar(
              radius: size! / 2,
              backgroundColor: Colors.grey.shade300,
            ),
          )
        : InkWell(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: CustomCachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: imageUrl,
                height: size,
                width: size,
              ),
            ),
          );
  }
}
