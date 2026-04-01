import 'package:flutter/material.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_Social_small_button.dart';

class CustomSocialAuthWidget extends StatelessWidget {
  const CustomSocialAuthWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomSocialSmallButton(
          onPressed: () {},
          image: Assets.assetsImagesFacebook,
        ),
        SizedBox(width: 20),
        CustomSocialSmallButton(
          onPressed: () {},
          image: Assets.assetsImagesGoogle,
        ),
      ],
    );
  }
}
