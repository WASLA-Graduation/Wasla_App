import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/auth/presentation/widgets/drop_down_color.dart';
import 'package:wasla/features/driver/features/home/data/models/driver_profile_model.dart';
import 'package:wasla/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:wasla/features/profile/presentation/widgets/driver_update_profile_files_type_car.dart';
import 'package:wasla/features/profile/presentation/widgets/driver_update_profile_form.dart';

class DriverEditProfileBody extends StatelessWidget {
  const DriverEditProfileBody({super.key, required this.driver});
  final DriverProfileModel driver;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 6, 30),
      child: Column(
        spacing: 20,
        children: [
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 20),
                DriverUpdateProfileForm(driver: driver),
                DriverUpdateProfileFilesTypeCar(driver: driver),
                const SizedBox(height: 20),
                DropDownColors(
                  onSelected: (color) {
                    context.read<ProfileCubit>().updateVehicleColor(color);
                  },
                ),
              ],
            ),
          ),
          GeneralButton(
            onPressed: () {
              context.pushScreen(AppRoutes.accountChangePassScreen);
            },
            text: "change_password".tr(context),
          ),
          BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is ProfileUpdateInfoFailure) {
                toastAlert(color: AppColors.error, msg: state.errMsg);
              }
              if (state is ProfileUpdateInfoSuccess) {
                toastAlert(
                  color: AppColors.acceptGreen,
                  msg: "profile_updated_success".tr(context),
                );
              }
            },
            builder: (context, state) {
              return GeneralButton(
                onPressed: () {
                  if (cubit.driverFormKey.currentState!.validate()) {
                    cubit.updateUsertInfo();
                  }
                },
                text: state is ProfileUpdateInfoLoading
                    ? 'loading'.tr(context)
                    : 'save'.tr(context),
              );
            },
          ),
        ],
      ),
    );
  }
}
