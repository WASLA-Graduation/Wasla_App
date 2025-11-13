import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_doc_complete_info_form.dart';

class CompleteInfoBody extends StatelessWidget {
  const CompleteInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthDoctorCompleteInfoFailure) {
          toastAlert(color: AppColors.error, msg: state.errMsg);
        } else if (state is AuthDoctorCompleteInfoSuccess) {
          context.pushReplacementScreen(AppRoutes.signInScreen);
        }
      },
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: CustomDoctorCompleteInfoForm(),
          ),
        ],
      ),
    );
  }
}
