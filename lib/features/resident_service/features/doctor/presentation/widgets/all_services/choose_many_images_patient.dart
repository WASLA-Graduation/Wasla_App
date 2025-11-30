import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/functions/get_image_from_device.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';

class ChoosePatientManyImageWidget extends StatelessWidget {
  const ChoosePatientManyImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorCubit>();
    return InkWell(
      onTap: () async {
        List<File> images = await pickMultipleImages();
        if (images.isNotEmpty) {
          cubit.uploadIImages(images);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 17),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.gray.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.image, color: AppColors.primaryColor, size: 26),
                const SizedBox(width: 10),
                Text(
                  "uploadImages".tr(context),
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: context.isDarkMode
                        ? AppColors.whiteColor70
                        : Colors.black54,
                  ),
                ),
              ],
            ),

            cubit.images.isNotEmpty
                ? Image.asset(Assets.assetsImagesAccept, width: 20, height: 20)
                : Icon(
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
