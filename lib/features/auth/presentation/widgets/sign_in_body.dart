import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/widgets/custom_desc_text_widget.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_auth_form.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_divder_text.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_social_auth_widget.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_span_widget.dart';
import 'package:wasla/features/auth/presentation/widgets/forgot_pass_widget.dart';
import 'package:wasla/features/auth/presentation/widgets/sign_in_button.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        VerticalSpace(height: 8),
        Image.asset(
          Assets.assetsImagesLogin,
          width: SizeConfig.screenWidth * 0.4,
          height: SizeConfig.screenWidth * 0.4,
        ),
        VerticalSpace(height: 3),
        Align(child: CustomDescriptionTextWidget(text: "login".tr(context))),
        VerticalSpace(height: 3),
        CustomAuthForm(formKey: cubit.singInformKey),
        const VerticalSpace(height: 3),
        SignInButton(),
        VerticalSpace(height: 3),
        ForgotPassWidget(),
        VerticalSpace(height: 3),
        CustomDividerText(text: "orContinueWith".tr(context)),
        VerticalSpace(height: 3),
        const CustomSocialAuthWidget(),
        VerticalSpace(height: 3),
        CustomTextSpanWidget(
          onTap: () => context.pushReplacementScreen(AppRoutes.signUpScreen),
          leadingText: "dontHaveAccount".tr(context),
          suffixText: "signUp".tr(context),
        ),
      ],
    );
  }
}
