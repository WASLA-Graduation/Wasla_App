import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/profile/presentation/manager/cubit/profile_cubit.dart';

class TechnicainEditProfileButttons extends StatelessWidget {
  const TechnicainEditProfileButttons({super.key, required this.isTablet});

  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return isTablet
        ? Row(
            children: [
              Expanded(child: _buildUpdateButton()),
              SizedBox(width: 20.w),
              Expanded(child: _buildChangePassButton(context)),
            ],
          )
        : Column(
            children: [
              _buildChangePassButton(context),

              SizedBox(height: 20.h),
              _buildUpdateButton(),
            ],
          );
  }

  BlocBuilder<ProfileCubit, ProfileState> _buildUpdateButton() {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final cubit = context.read<ProfileCubit>();
        return GeneralButton(
          onPressed: () {
            if (cubit.technicainFormKey.currentState!.validate()) {
              cubit.updateUsertInfo();
            }
          },
          text: state is ProfileUpdateInfoLoading
              ? "loading".tr(context)
              : "update".tr(context),
        );
      },
    );
  }

  GeneralButton _buildChangePassButton(BuildContext context) {
    return GeneralButton(
      onPressed: () {
        context.pushScreen(AppRoutes.accountChangePassScreen);
      },
      text: "change_password".tr(context),
    );
  }
}
