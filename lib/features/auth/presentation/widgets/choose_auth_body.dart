import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
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

class ChooseAuthBody extends StatelessWidget {
  const ChooseAuthBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VerticalSpace(height: 8),
        const SizedBox(height: 10),
        Image.asset(
          Assets.assetsImagesChooseAuth,
          width: SizeConfig.screenWidth * 0.6,
          height: SizeConfig.screenWidth * 0.6,
        ),
        CustomDescriptionTextWidget(text: "letsYouIn".tr(context)),
        VerticalSpace(height: 7),
        CustomSocialMediaButton(
          onPressed: () {},
          image: Assets.assetsImagesFacebook,
          text: "continueWithFacebook".tr(context),
        ),
        CustomSocialMediaButton(
          onPressed: () {},
          image: Assets.assetsImagesGoogle,
          text: "continueWithGoogle".tr(context),
        ),
        VerticalSpace(height: 2),
        CustomDividerText(text: "or".tr(context)),
        VerticalSpace(height: 2),
        GeneralButton(
          onPressed: () {
            context.pushScreen(AppRoutes.signInScreen);
          },
          text: "signInWithPassword".tr(context),
        ),
        VerticalSpace(height: 3),
        CustomTextSpanWidget(
          leadingText: "dontHaveAccount".tr(context),
          suffixText: "signUp".tr(context),
          onTap: () {
            context.pushScreen(AppRoutes.signUpScreen);
          },
        ),
        VerticalSpace(height: 7),
      ],
    );
  }
}
