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
            clipBehavior: Clip.hardEdge,
            children: [
              _getCircleWidget(),
              _getBubblesWidget(),
              _getImageWidget(),
            ],
          ),
        ),
        const SizedBox(height: 20),
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
        radius: SizeConfig.blockWidth * 37,
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }

  Widget _getBubblesWidget() {
    return Stack(
      children: [
        _bubble(top: 40, left: 50, size: 10),
        _bubble(top: 80, right: 70, size: 14),
        _bubble(top: 160, left: 20, size: 8),
        _bubble(bottom: 60, right: 30, size: 12),
        _bubble(bottom: 100, left: 90, size: 16),
      ],
    );
  }

  Positioned _bubble({double? top, double? left, double? right, double? bottom, required double size}) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
