import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/restaurant/menu/presentation/widgets/add%20menu/add_menu_category.dart';
import 'package:wasla/features/restaurant/menu/presentation/widgets/add%20menu/add_menu_form.dart';

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
          AddMenuForm(),
          SizedBox(height: AppSizes.paddingSizeDefault),
          AddMenuCategory(),
          SizedBox(height: AppSizes.paddingSizeDefault),
          GeneralButton(onPressed: () {}, text: 'addMenu'.tr(context)),
          SizedBox(height: AppSizes.paddingSizeDefault),
        ],
      ),
    );
  }
}
