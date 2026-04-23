import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/restaurant/menu/presentation/manager/cubit/resident_menu_cubit.dart';
import 'package:wasla/features/restaurant/menu/presentation/widgets/add%20menu/add_menu_category.dart';
import 'package:wasla/features/restaurant/menu/presentation/widgets/add%20menu/add_menu_form.dart';
import 'package:wasla/features/restaurant/menu/presentation/widgets/add%20menu/add_menu_image.dart';

class AddMenuItemBody extends StatelessWidget {
  const AddMenuItemBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.marginDefault,
        vertical: AppSizes.paddingSizeEight,
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const AddMenuForm(),
                SizedBox(height: AppSizes.paddingSizeDefault),
                const AddMenuCategory(),
                SizedBox(height: AppSizes.paddingSizeDefault),
                const AddMenuImage(),
              ],
            ),
          ),
          SizedBox(height: AppSizes.paddingSizeDefault),
          BlocConsumer<ResidentMenuCubit, ResidentMenuState>(
            listener: (context, state) {
              if (state is ResidentAddOrUpdateMenuItemSuccessState) {
                showToast('menuAdded'.tr(context));
                Navigator.pop(context);
              } else if (state is ResidentAddOrUpdateMenuItemFailureState) {
                showToast(state.errMsg, color: Colors.red);
              }
            },
            builder: (context, state) {
              final cubit = context.read<ResidentMenuCubit>();
              return GeneralButton(
                onPressed: () {
                  if (cubit.addMenuFormKey.currentState!.validate() &&
                      cubit.menuImage != null &&
                      state is! ResidentAddOrUpdateMenuItemLoadingState) {
                    cubit.addMenuItem();
                  }
                },
                text: state is ResidentAddOrUpdateMenuItemLoadingState
                    ? 'loading'.tr(context)
                    : 'addMenu'.tr(context),
              );
            },
          ),
          SizedBox(height: AppSizes.paddingSizeDefault),
        ],
      ),
    );
  }
}
