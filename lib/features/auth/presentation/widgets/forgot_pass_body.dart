import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/widgets/custom_lable_sub_lable_widget.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_forgot_pass_form.dart';

class ForgotPassBody extends StatelessWidget {
  const ForgotPassBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        VerticalSpace(height: 2),
        CustomLableSubLableWidget(
          title: "forgotPasswordTitle".tr(context),
          subTitle: "forgotPasswordSubTitle".tr(context),
        ),
        VerticalSpace(height: 3),
        Image.asset(
          Assets.assetsImagesForgotPass,
          width: SizeConfig.screenWidth * 0.6,
          height: SizeConfig.screenWidth * 0.6,
        ),
        VerticalSpace(height: 2),
        const CustomForgotPassForm(),
      ],
    );
  }
}