import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/gym_complete_info_form.dart';

class GymCompleteInfoBody extends StatelessWidget {
  const GymCompleteInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Column(
      spacing: 20,
      children: [
        Expanded(child: GymCompleteInfoForm()),
        BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthGymCompleteInfoFailure) {
              toastAlert(color: AppColors.error, msg: state.errMsg);
            }
            if (state is AuthGymCompleteInfoSuccess) {
              context.pushReplacementScreen(AppRoutes.signInScreen);
            }
          },
          builder: (context, state) {
            return GeneralButton(
              onPressed: () {
                if (cubit.gymInfoformKey.currentState!.validate()) {
                  cubit.gymCompleteInfo();
                }
              },
              text: state is AuthGymCompleteInfoLoading
                  ? 'loading'.tr(context)
                  : 'save'.tr(context),
            );
          },
        ),
      ],
    );
  }
}
