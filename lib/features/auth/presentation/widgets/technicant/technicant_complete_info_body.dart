import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/technicant/technicant_info_list_view.dart';

class TechnicantCompleteInfoBody extends StatelessWidget {
  const TechnicantCompleteInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Column(
      children: [
        SizedBox(height: 20.h),
        Expanded(child: TechnicantInfoListView()),
        BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is TechnicantCompleteInfoFailure) {
              toastAlert(color: AppColors.error, msg: state.errMsg);
            }
            if (state is AuthTechnicantCompleteInfoSuccess) {
              context.pushReplacementScreen(AppRoutes.signInScreen);
            }
          },
          builder: (context, state) {
            return GeneralButton(
              onPressed: () {
                if (cubit.technicantInfoformKey.currentState!.validate()) {
                  cubit.technicantCompleteInfo();
                }
              },
              text: state is AuthTechnicantCompleteInfoLoading
                  ? 'loading'.tr(context)
                  : 'save'.tr(context),
            );
          },
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
