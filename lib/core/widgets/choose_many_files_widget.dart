import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/functions/get_file_from_device.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';

class ChooseManyFilesWidget extends StatelessWidget {
  const ChooseManyFilesWidget({
    super.key,
    required this.files,
    required this.onFilesSelected,
    this.hintText,
    this.height = 60,
  });

  final List<PlatformFile> files;
  final Function(List<PlatformFile>) onFilesSelected;
  final String? hintText;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        List<PlatformFile> pickedFiles = await getMultipleFilesFromDevice();
        if (pickedFiles.isNotEmpty) {
          onFilesSelected(pickedFiles);
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
                Icon(
                  Icons.attach_file,
                  color: AppColors.primaryColor,
                  size: 26,
                ),
                const SizedBox(width: 10),
                Text(
                  files.isNotEmpty
                      ? '${files.length} files selected'
                      : hintText ?? "Upload Files",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: context.isDarkMode
                        ? AppColors.whiteColor70
                        : Colors.black54,
                  ),
                ),
              ],
            ),
            files.isNotEmpty
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
