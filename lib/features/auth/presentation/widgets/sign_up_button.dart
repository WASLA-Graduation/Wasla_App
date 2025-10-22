import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignUpFailure) {
          toastAlert(color: AppColors.error, msg: state.errMsg);
        } else if (state is AuthSignUpSuccess) {
          context.pushReplacementScreen(
            AppRoutes.verifyScreen,
            arguments: AppRoutes.residentInfoScreen,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<AuthCubit>();
        return state is AuthSignUpLoading
            ? Center(child: CircularProgressIndicator())
            : GeneralButton(
                onPressed: () async {
                  if (cubit.singUpformKey.currentState!.validate()) {
                    await cubit.signUpWithEmailAndPassword();
                  }
                },
                text: "signUp".tr(context),
              );
      },
    );
  }
}
