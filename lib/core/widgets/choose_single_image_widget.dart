import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/functions/get_image_from_device.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';

class ChooseSingleImageWidget extends StatelessWidget {
  const ChooseSingleImageWidget({
    super.key,
    required this.image,
    required this.onImageSelected,
    this.hintText,
    this.height = 60,
  });

  final File? image;
  final Function(File) onImageSelected;
  final String? hintText;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        File? pickedImage = await getImageFromMobile(fromGallary: true);

        if (pickedImage != null) {
          onImageSelected(pickedImage);
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
          children: [
            Icon(Icons.image, color: AppColors.primaryColor, size: 26),
            const SizedBox(width: 10),

            Expanded(
              child: Text(
                image != null
                    ? image!.path.split('/').last
                    : hintText ?? "Upload Image",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: context.isDarkMode
                      ? AppColors.whiteColor70
                      : Colors.black54,
                ),
              ),
            ),

            image != null
                ? Image.asset(Assets.assetsImagesAccept, width: 20, height: 20)
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
