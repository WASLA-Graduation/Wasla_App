import 'package:flutter/material.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/profile/presentation/widgets/custom_change_pass_form.dart';

class AccountChangePassBody extends StatelessWidget {
  const AccountChangePassBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
                VerticalSpace(height: 2),
        Image.asset(
          Assets.assetsImagesForgotPass,
          width: SizeConfig.screenWidth * 0.7,
          height: SizeConfig.screenWidth * 0.7,
        ),
        VerticalSpace(height: 3),
            ],
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: CustomChangePassForm(),
        ),
      ],
    );
  }
}
