import 'package:flutter/material.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/general_button.dart';

class DoctorRemoveServiceDialog extends StatelessWidget {
  const DoctorRemoveServiceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(25),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 15,
          children: [
            Image.asset(
              Assets.assetsImagesDelete,
              height: 60,
              color: AppColors.red,
            ),
            Text(
              "Are you Sure ?",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Do you really want to delete Teeth Cleaning?",
                style: Theme.of(
                  context,
                ).textTheme.displaySmall!.copyWith(color: AppColors.gray),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GeneralButton(
                    onPressed: () {
                      context.popScreen();
                    },
                    text: 'Cancel',
                    color: const Color(0xFFd1d5db),
                    height: 40,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: GeneralButton(
                    onPressed: () {},
                    text: 'Delete',
                    color: AppColors.red,
                    height: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
