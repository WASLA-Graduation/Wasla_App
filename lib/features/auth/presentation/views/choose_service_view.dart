import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/database/cache/shared_preferences_helper.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/core/utils/size_config.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/onboarding/presentation/widgets/custom_service_roles_list_widget.dart';

class ChooseServiceView extends StatelessWidget {
  const ChooseServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockWidth * 6,
          vertical: SizeConfig.blockHeight * 8,
        ),
        child: Column(
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
                await SharedPreferencesHelper.set(
                  key: 'onboardingVisited',
                  value: true,
                ).then((value) {
                  context.pushScreen(AppRoutes.chooseAuthScreen);
                });
              },
              text: "continue".tr(context),
            ),
          ],
        ),
      ),
    );
  }
}
