import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      appBar: AppBar(title: Text("Verification Code")),

      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockWidth * 5,
            ),
            children: [
              VerticalSpace(height: 7),
              Text(
                textAlign: TextAlign.center,
                "Code has been Send to your email",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              VerticalSpace(height: 5),
              CustomOtpField(),
              VerticalSpace(height: 5),
              Text(
                textAlign: TextAlign.center,
                "Resend Code In ${cubit.remainingSeconds} s",
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(color: AppColors.primaryColor),
              ),
              VerticalSpace(height: 5),
              GeneralButton(
                color: cubit.enableButton
                    ? AppColors.primaryColor
                    : AppColors.gray,
                onPressed: () {},
                text: "Verify",
              ),
            ],
          );
        },
      ),
    );
  }
}
