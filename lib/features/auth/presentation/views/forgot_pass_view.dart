import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/utils/size_config.dart';
import 'package:wasla/core/widgets/custom_lable_sub_lable_widget.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_forgot_pass_form.dart';

class ForgotPassView extends StatelessWidget {
  const ForgotPassView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 5),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            VerticalSpace(height: 2),
            CustomLableSubLableWidget(
              title: "Forgot Password?",
              subTitle:
                  "Enter your email address to verify and reset your password",
            ),
            VerticalSpace(height: 3),
            Image.asset(
              Assets.assetsImagesForgotPass,
              width: SizeConfig.screenWidth * 0.6,
              height: SizeConfig.screenWidth * 0.6,
            ),
            VerticalSpace(height: 2),
            CustomForgotPassForm(),
          ],
        ),
      ),
    );
  }
}
