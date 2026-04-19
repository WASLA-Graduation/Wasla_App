import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:wasla/features/profile/presentation/widgets/restaurant/restuarnt_edit_profile_form.dart';
import 'package:wasla/features/restaurant/home/data/models/restaurant_model.dart';

class RestaurantEditProfileBody extends StatelessWidget {
  const RestaurantEditProfileBody({super.key, required this.restaurantModel});
  final RestaurantModel restaurantModel;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingSizeDefault),
      child: Column(
        spacing: AppSizes.paddingSizeLarge,
        children: [
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              children: [
                SizedBox(height: AppSizes.paddingSizeDefault),
                RestaurantEditProfileForm(restaurantModel: restaurantModel),
                SizedBox(height: AppSizes.paddingSizeDefault),
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
                  if (cubit.restaurantFormKey.currentState!.validate()) {
                    cubit.updateUsertInfo();
                  }
                },
                text: state is ProfileUpdateInfoLoading
                    ? 'loading'.tr(context)
                    : 'save'.tr(context),
              );
            },
          ),
          SizedBox(height: AppSizes.paddingSizeDefault),
        ],
      ),
    );
  }
}
