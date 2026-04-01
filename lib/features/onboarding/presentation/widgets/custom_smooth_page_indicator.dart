import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/onboarding/data/models/onboarding_model.dart';
import 'package:wasla/features/onboarding/presentation/manager/cubit/onboarding_cubit.dart';

class CustomSmoothPageIndicator extends StatelessWidget {
  const CustomSmoothPageIndicator({super.key, required this.onboardingManager});

  final OnboardingCubit onboardingManager;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            OnboardingModel.onboardingList.length,
            (index) => AnimatedContainer(
              duration: Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: 5),
              width: onboardingManager.currentIndex == index ? 20 : 10,
              height: 7,
              decoration: BoxDecoration(
                color: onboardingManager.currentIndex == index
                    ? AppColors.primaryColor
                    : AppColors.gray,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      },
    );
  }
}