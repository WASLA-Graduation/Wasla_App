import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/features/onboarding/data/models/onboarding_model.dart';

class PageViewBody extends StatelessWidget {
  const PageViewBody({super.key, required this.onboardingModel});
  final OnboardingModel onboardingModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: SizeConfig.screenHeight / 2,
          child: Stack(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            children: [_getCircleWidget(), _getImageWidget()],
          ),
        ),
        SizedBox(height: 20),
        _getDescriptionWidget(context),
      ],
    );
  }

  Text _getDescriptionWidget(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      onboardingModel.description.tr(context),
      style: Theme.of(context).textTheme.labelLarge,
    );
  }

  Positioned _getImageWidget() {
    return Positioned(
      bottom: -35,
      left: 0,
      right: 0,
      height: SizeConfig.blockHeight * 58,
      child: Image.asset(fit: BoxFit.cover, onboardingModel.image),
    );
  }

  Align _getCircleWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: CircleAvatar(
        radius: SizeConfig.blockWidth * 40,
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }
}
