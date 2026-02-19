import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/functions/download_image.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/cached_network_image_widget.dart';
import 'package:wasla/core/widgets/general_button.dart';

class QrCodeDialog extends StatelessWidget {
  const QrCodeDialog({super.key, required this.qrCode});
  final String qrCode;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: context.isDarkMode
              ? AppColors.blackColor
              : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'bookingConfirmed'.tr(context),
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'showQr'.tr(context),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall!,
            ),
            const SizedBox(height: 20),
            CustomCachedNetworkImage(imageUrl: qrCode, height: 180, width: 180),
            const SizedBox(height: 20),

            GeneralButton(
              text: 'downloadQr'.tr(context),
              onPressed: () {
                downloadImage(qrCode);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
