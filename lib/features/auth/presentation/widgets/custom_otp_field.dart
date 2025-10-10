import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';

class CustomOtpField extends StatelessWidget {
  const CustomOtpField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    final baseTheme = PinTheme(
      width: 60,
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      textStyle: Theme.of(
        context,
      ).textTheme.titleLarge!.copyWith(color: AppColors.primaryColor),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: AppColors.primaryColor),
      ),
    );

    return Pinput(
      autofocus: true,
      autofillHints: const [],
      enabled: true,
      onCompleted: (code) {
        cubit.otpCode = code;
        cubit.enableVerifyButton();
      },
      defaultPinTheme: baseTheme,
      focusedPinTheme: baseTheme.copyWith(
        decoration: baseTheme.decoration!.copyWith(
          color: AppColors.primaryColor.withOpacity(0.1),
          border: Border.all(width: 2, color: AppColors.primaryColor),
        ),
      ),
      submittedPinTheme: baseTheme.copyWith(
        decoration: baseTheme.decoration!.copyWith(
          color: AppColors.primaryColor.withOpacity(0.15),
          border: Border.all(width: 1.5, color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
