import 'package:flutter/material.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/utils/size_config.dart';
import 'package:wasla/core/widgets/custom_desc_text_widget.dart';
import 'package:wasla/core/widgets/custom_social_media_button.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_divder_text.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_span_widget.dart';

class ChooseAuthView extends StatelessWidget {
  const ChooseAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 5),
        child: Column(
          children: [
            VerticalSpace(height: 8),
            const SizedBox(height: 10),
            Image.asset(
              Assets.assetsImagesChooseAuth,
              width: SizeConfig.screenWidth * 0.6,
              height: SizeConfig.screenWidth * 0.6,
            ),
            CustomDescriptionTextWidget(text: "Let's you in"),
            VerticalSpace(height: 7),

            CustomSocialMediaButton(
              onPressed: () {},
              image: Assets.assetsImagesFacebook,
              text: "Continue with Facebook",
            ),
            CustomSocialMediaButton(
              onPressed: () {},
              image: Assets.assetsImagesGoogle,
              text: "Continue with Google",
            ),
            VerticalSpace(height: 2),
            CustomDividerText(text: " Or "),
            VerticalSpace(height: 2),
            GeneralButton(
              onPressed: () {
                context.pushScreen(AppRoutes.signInScreen);
              },
              text: "Sign in with Password",
            ),
            VerticalSpace(height: 3),
            CustomTextSpanWidget(
              leadingText: "Don't have an account ? ",
              suffixText: "Sign Up",
              onTap: () {
                context.pushScreen(AppRoutes.signUpScreen);
              },
            ),
            VerticalSpace(height: 7),
          ],
        ),
      ),
    );
  }
}
