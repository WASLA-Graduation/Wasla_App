import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/utils/size_config.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_reset_pass_form.dart';

class ResetPassView extends StatelessWidget {
  const ResetPassView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create New Password")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 5),
        child: ListView(
          padding: EdgeInsets.zero,

          children: [
            VerticalSpace(height: 2),
            Image.asset(
              Assets.assetsImagesForgotPass,
              width: SizeConfig.screenWidth * 0.7,
              height: SizeConfig.screenWidth * 0.7,
            ),
            VerticalSpace(height: 3),
            CustomResetPassForm(),
          ],
        ),
      ),
    );
  }
}
