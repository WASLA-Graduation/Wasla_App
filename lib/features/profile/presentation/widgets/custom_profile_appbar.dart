import 'package:flutter/material.dart';
import 'package:wasla/core/utils/assets.dart';

class CustomProfileAppbar extends StatelessWidget {
  const CustomProfileAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Text(
          "Profile",
          style: Theme.of(
            context,
          ).textTheme.displayMedium,
        ),

        Image.asset(Assets.assetsImagesMore, width: 20),
      ],
    );
  }
}
