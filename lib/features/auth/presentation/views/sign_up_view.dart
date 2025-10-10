import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/utils/size_config.dart';
import 'package:wasla/core/widgets/custom_desc_text_widget.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_divder_text.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_auth_form.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_social_auth_widget.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_span_widget.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 5),

        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            VerticalSpace(height: 8),
            VerticalSpace(height: 5),
            Image.asset(
              Assets.assetsImagesLogin,
              width: SizeConfig.screenWidth * 0.4,
              height: SizeConfig.screenWidth * 0.4,
            ),
            Align(
              child: CustomDescriptionTextWidget(text: "Create your account"),
            ),
            VerticalSpace(height: 4),
            CustomAuthForm(formKey: cubit.singUpformKey),
            const VerticalSpace(height: 3),
            GeneralButton(
              onPressed: () {
                if (cubit.singUpformKey.currentState!.validate()) {
                  context.pushScreen(AppRoutes.verifyScreen);
                }
              },
              text: "Sign Up",
            ),
            VerticalSpace(height: 3),
            CustomDividerText(text: " Or Continue with "),
            VerticalSpace(height: 3),
            CustomSocialAuthWidget(),
            VerticalSpace(height: 3),
            CustomTextSpanWidget(
              onTap: () =>
                  context.pushReplacementScreen(AppRoutes.signInScreen),
              leadingText: "Already have an account?",
              suffixText: "Sign In",
            ),
          ],
        ),
      ),
    );
  }
}
