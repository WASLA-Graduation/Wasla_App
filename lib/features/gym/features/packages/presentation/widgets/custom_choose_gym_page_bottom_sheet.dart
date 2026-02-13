import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/under_line_widget.dart';

class CustomChooseGymPageBottomSheet extends StatelessWidget {
  const CustomChooseGymPageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        spacing: 17,
        mainAxisSize: MainAxisSize.min,
        children: [
          UnderLineWidget(),
          _buildTextWidget(
            context,
            title: "addNewPackage".tr(context),
            route: "/addPackage",
          ),
          _buildTextWidget(
            context,
            title: "addNewOffer".tr(context),
            route: "/addOffer",
          ),
        ],
      ),
    );
  }

  InkWell _buildTextWidget(
    BuildContext context, {
    required String title,
    required String route,
  }) => InkWell(
    onTap: () {
      context.pushScreen(route);
    },
    child: Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.headlineMedium!.copyWith(color: AppColors.primaryColor),
    ),
  );
}
