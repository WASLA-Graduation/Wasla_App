import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';

class ForgotPassWidget extends StatelessWidget {
  const ForgotPassWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      child: InkWell(
        onTap: () {
          context.pushScreen(AppRoutes.forgotScreen);
        },
        child: Text(
          "forgotPassword".tr(context),
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}