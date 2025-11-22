import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/assets.dart';

class CustomProfileAppbar extends StatelessWidget {
  const CustomProfileAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Text(
          "profile".tr(context),
          style: Theme.of(context).textTheme.headlineMedium,
        ),

        Image.asset(
          Assets.assetsImagesMore,
          width: 20,
          color: context.isDarkMode ? Colors.white : Colors.black,
        ),
      ],
    );
  }
}
