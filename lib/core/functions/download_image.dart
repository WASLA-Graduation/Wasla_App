import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';

Future<void> downloadImage(String imageUrl) async {
  try {
    final Directory dir = await getApplicationDocumentsDirectory();

    final String fileName =
        "image_${DateTime.now().millisecondsSinceEpoch}.jpg";

    final String savePath = "${dir.path}/$fileName";

    await Dio().download(imageUrl, savePath);

    toastAlert(color: AppColors.green, msg: "Image downloaded successfully");
  } catch (e) {
    toastAlert(color: AppColors.error, msg: "Failed to download image");
  }
}
