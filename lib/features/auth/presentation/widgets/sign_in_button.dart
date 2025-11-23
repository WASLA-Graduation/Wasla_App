import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/get_right_route.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/views/user_waiting_view.dart';

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
          if (!cubit.dataModel.isVerified) {
            cubit.forgotPassCheckEmail().then((value) {
              context.pushReplacementScreen(
                AppRoutes.verifyScreen,
                arguments: getRightCompleteServiceRoute(
                  role: cubit.dataModel.role,
                ),
              );
            });
          } else if (!cubit.dataModel.isCompleteRegister) {
            context.pushReplacementScreen(
              getRightCompleteServiceRoute(role: cubit.dataModel.role),
            );
          } else if (cubit.dataModel.statue == 2) {
            ///user is pending
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const UserWaitingView(
                  image: Assets.assetsImagesPending,
                  title: "pending_title",
                  subTitle: "pending_desc",
                ),
              ),
            );
          } else if (cubit.dataModel.statue == 1) {
            //user suspended

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const UserWaitingView(
                  image: Assets.assetsImagesSuspend,
                  title: "suspended_title",
                  subTitle: "suspended_desc",
                ),
              ),
            );
          } else if (cubit.dataModel.statue == 3) {
            //user disabled
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const UserWaitingView(
                  image: Assets.assetsImagesPannd,
                  title: "disabled_title",
                  subTitle: "disabled_desc",
                ),
              ),
            );
          } else {
            cubit.saveSignInData();
            context.pushReplacementScreen(getRightRoute(role: cubit.dataModel.role));
          }
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
