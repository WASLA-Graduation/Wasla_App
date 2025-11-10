import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/widgets/custom_lable_sub_lable_widget.dart';

class CustomDoneWidget extends StatelessWidget {
  const CustomDoneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      content: SizedBox(
        height: SizeConfig.blockHeight * 50,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              Assets.assetsImagesDone,
              width: SizeConfig.blockWidth * 50,
              height: SizeConfig.blockWidth * 50,
            ),
            CustomLableSubLableWidget(
              color: AppColors.primaryColor,
              title: "congratulations".tr(context),
              subTitle: "accountReady".tr(context),
            ),
            const VerticalSpace(height: 5),
            SpinKitFadingCircle(color: AppColors.primaryColor, size: 50.0),
          ],
        ),
      ),
    );
  }
}
