import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/restaurant/restaurant_complete_info_list.dart';

class RestaurantCompleteInfoBody extends StatelessWidget {
  const RestaurantCompleteInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingSizeDefault),
      child: Column(
        children: [
          SizedBox(height: AppSizes.paddingSizeDefault),
          Expanded(child: const RestaurantCompleteInfoList()),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is RestaurantCompleteInfoFailure) {
                toastAlert(color: AppColors.error, msg: state.errMsg);
              }
              if (state is AuthRestaurantCompleteInfoSuccess) {
                context.pushReplacementScreen(AppRoutes.signInScreen);
              }
            },
            builder: (context, state) {
              return GeneralButton(
                onPressed: () {
                  if (cubit.restaurantInfoFormKey.currentState!.validate()) {
                    cubit.restaurantCompleteInfo();
                  }
                },
                text: state is AuthRestaurantCompleteInfoLoading
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
