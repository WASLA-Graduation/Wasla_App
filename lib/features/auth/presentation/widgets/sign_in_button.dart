import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/get_right_route.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignInFailure) {
          toastAlert(color: AppColors.error, msg: state.errMsg);
        } else if (state is AuthSignInSuccess) {
          context.pushScreen(getRightRoute(role: cubit.dataModel.role));
        }
      },
      builder: (context, state) {
        return GeneralButton(
          onPressed: () async {
            if (cubit.singInformKey.currentState!.validate()) {
              await cubit.signInWithEmailAndPassword();
            }
          },
          text: state is AuthSignInLoading
              ? "loading".tr(context)
              : "signIn".tr(context),
        );
      },
    );
  }
}
