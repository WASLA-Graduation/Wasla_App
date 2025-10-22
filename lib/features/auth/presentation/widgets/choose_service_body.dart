import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/onboarding/presentation/widgets/custom_service_roles_list_widget.dart';

class ChooseServiceBody extends StatelessWidget {
  const ChooseServiceBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          textAlign: TextAlign.center,
          "chooseYourService".tr(context),
          style: Theme.of(context).textTheme.labelLarge,
        ),

        VerticalSpace(height: 3),
        CustomServiceRolesListWidget(),
        VerticalSpace(height: 4),
        GeneralButton(
          onPressed: () async {
            context.pushReplacementScreen(AppRoutes.chooseAuthScreen);
          },
          text: "continue".tr(context),
        ),
      ],
    );
  }
}
