import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/database/cache/shared_preferences_helper.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/app_strings.dart';
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
          onPressed: () async {
            if (onboardingManager.currentIndex ==
                OnboardingModel.onboardingList.length - 1) {
              await SharedPreferencesHelper.set(
                key: AppStrings.onboardingVisited,
                value: true,
              ).then((value) {
                context.pushScreen(AppRoutes.chooseAuthScreen);
              });
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
