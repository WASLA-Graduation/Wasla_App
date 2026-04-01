import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/onboarding/data/models/onboarding_model.dart';
import 'package:wasla/features/onboarding/presentation/manager/cubit/onboarding_cubit.dart';

class CustomSkipWidget extends StatelessWidget {
  const CustomSkipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<OnboardingCubit>();
    return Visibility(
      visible: cubit.currentIndex != OnboardingModel.onboardingList.length - 1
          ? true
          : false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: GestureDetector(
          onTap: () {
            cubit.pageController.animateToPage(
              OnboardingModel.onboardingList.length - 1,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          child: Align(
            alignment: Alignment.topRight,
            child: Text(
              "skip".tr(context),
              style: TextStyle(
                fontSize: 18,
                color: context.isDarkMode
                    ? AppColors.whiteColor
                    : AppColors.blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
