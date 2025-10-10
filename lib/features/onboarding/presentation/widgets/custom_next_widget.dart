import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/onboarding/data/models/onboarding_model.dart';
import 'package:wasla/features/onboarding/presentation/manager/cubit/onboarding_cubit.dart';

class CustomNextWidget extends StatelessWidget {
  const CustomNextWidget({super.key, required this.onboardingManager});

  final OnboardingCubit onboardingManager;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return GeneralButton(
          onPressed: () {
            if (onboardingManager.currentIndex ==
                OnboardingModel.onboardingList.length - 1) {
              context.pushReplacementScreen(AppRoutes.chooseServiceScreen);
            }
            onboardingManager.nextPage();
          },
          text:
              onboardingManager.currentIndex ==
                  OnboardingModel.onboardingList.length - 1
              ? "getStarted".tr(context)
              : "next".tr(context),
        );
      },
    );
  }
}
