
import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/utils/size_config.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_reset_pass_form.dart';

class ResetPassBody extends StatelessWidget {
  const ResetPassBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        VerticalSpace(height: 2),
        Image.asset(
          Assets.assetsImagesForgotPass,
          width: SizeConfig.screenWidth * 0.7,
          height: SizeConfig.screenWidth * 0.7,
        ),
        VerticalSpace(height: 3),
        const CustomResetPassForm(),
      ],
    );
  }
}
