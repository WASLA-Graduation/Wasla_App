import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_otp_field.dart';

class VerificationCodeBody extends StatelessWidget {
  const VerificationCodeBody({super.key, required this.nextRoute});
  final String nextRoute;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthVerifyEmailFailure) {
          toastAlert(color: AppColors.error, msg: state.errMsg);
        } else if (state is AuthVerifyEmailSuccess) {
          cubit.timer?.cancel();
          context.pushReplacementScreen(nextRoute);
        }
      },
      builder: (context, state) {
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 5),
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
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(color: AppColors.primaryColor),
            ),
            const VerticalSpace(height: 5),
            GeneralButton(
              color: cubit.enableButton
                  ? AppColors.primaryColor
                  : AppColors.gray,
              onPressed: () async {
                await cubit.verifyEmail();
              },
              text: state is AuthVerifyEmailLoading
                  ? "loading".tr(context)
                  : "verify".tr(context),
            ),
          ],
        );
      },
    );
  }
}
