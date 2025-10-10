import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/core/utils/size_config.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_otp_field.dart';

class VerificationCodeView extends StatelessWidget {
  const VerificationCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Scaffold(
      appBar: AppBar(title: Text("verificationCode".tr(context))),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockWidth * 5,
            ),
            children: [
              const VerticalSpace(height: 7),
              Text(
                "codeSentToEmail".tr(context),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const VerticalSpace(height: 5),
              const CustomOtpField(),
              const VerticalSpace(height: 5),
              Text(
                "${"resendCodeIn".tr(context)} ${cubit.remainingSeconds} s",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: AppColors.primaryColor),
              ),
              const VerticalSpace(height: 5),
              GeneralButton(
                color: cubit.enableButton
                    ? AppColors.primaryColor
                    : AppColors.gray,
                onPressed: () {},
                text: "verify".tr(context),
              ),
            ],
          );
        },
      ),
    );
  }
}
