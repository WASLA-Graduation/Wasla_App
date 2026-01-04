import 'package:flutter/material.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';

class UploadFileButton extends StatelessWidget {
  const UploadFileButton({
    super.key,
    required this.title,
    required this.onTap,
    this.fileName,
    this.isUploaded = false,
    this.icon = Icons.upload_file,
  });

  final String title;
  final String? fileName;
  final bool isUploaded;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.gray.withOpacity(0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColors.primaryColor.withOpacity(0.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon,
                    color: AppColors.primaryColor,
                    size: 26),
                const SizedBox(width: 10),
                Text(
                  fileName ?? title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(
                        color: context.isDarkMode
                            ? AppColors.whiteColor70
                            : Colors.black54,
                      ),
                ),
              ],
            ),
            isUploaded
                ? Image.asset(
                    Assets.assetsImagesAccept,
                    width: 22,
                    height: 22,
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
