import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
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

class SignInView extends StatelessWidget {
  const SignInView({super.key});

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
            Image.asset(
              Assets.assetsImagesLogin,
              width: SizeConfig.screenWidth * 0.4,
              height: SizeConfig.screenWidth * 0.4,
            ),
            VerticalSpace(height: 3),
            Align(
              child: CustomDescriptionTextWidget(text: "Login to your account"),
            ),
            VerticalSpace(height: 3),
            CustomAuthForm(formKey: cubit.singInformKey),
            const VerticalSpace(height: 3),
            GeneralButton(
              onPressed: () {
                if (cubit.singInformKey.currentState!.validate()) {
                  // handle sign up
                }
              },
              text: "Sign In",
            ),
            VerticalSpace(height: 3),
            Align(
              child: InkWell(
                onTap: () {
                  context.pushScreen(AppRoutes.forgotScreen);
                },
                child: Text(
                  "Forgot the password ?",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
            VerticalSpace(height: 3),
            CustomDividerText(text: " Or Continue with "),
            VerticalSpace(height: 3),
            CustomSocialAuthWidget(),
            VerticalSpace(height: 3),
            CustomTextSpanWidget(
              onTap: () =>
                  context.pushReplacementScreen(AppRoutes.signUpScreen),
              leadingText: "Don't have an account?",
              suffixText: "Sign Up",
            ),
          ],
        ),
      ),
    );
  }
}
