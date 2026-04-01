import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/functions/get_image_from_device.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';

class ChooseManyImageWidget extends StatelessWidget {
  const ChooseManyImageWidget({
    super.key,
    required this.images,
    required this.onImagesSelected,
    this.hintText,
    this.height = 60,
  });

  final List<File> images;
  final Function(List<File>) onImagesSelected;
  final String? hintText;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        List<File> pickedImages = await pickMultipleImages();
        if (pickedImages.isNotEmpty) {
          onImagesSelected(pickedImages);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 17),
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.gray.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.image,
                    color: AppColors.primaryColor, size: 26),
                const SizedBox(width: 10),
                Text(
                  images.isNotEmpty
                      ? images.length.toString()
                      : hintText ?? "Upload Images",
                  style:
                      Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: context.isDarkMode
                                ? AppColors.whiteColor70
                                : Colors.black54,
                          ),
                ),
              ],
            ),
            images.isNotEmpty
                ? Image.asset(
                    Assets.assetsImagesAccept,
                    width: 20,
                    height: 20,
                  )
                : const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 18,
                    color: Colors.grey,
                  ),
          ],
        ),
      ),
    );
  }
}
