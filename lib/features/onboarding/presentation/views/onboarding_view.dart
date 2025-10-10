import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/onboarding/data/models/onboarding_model.dart';
import 'package:wasla/features/onboarding/presentation/manager/cubit/onboarding_cubit.dart';
import 'package:wasla/features/onboarding/presentation/widgets/custom_next_widget.dart';
import 'package:wasla/features/onboarding/presentation/widgets/custom_smooth_page_indicator.dart';
import 'package:wasla/features/onboarding/presentation/widgets/page_veiw_body.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingManager = context.read<OnboardingCubit>();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) =>
                    onboardingManager.updateCurrentIndex(value),
                controller: onboardingManager.pageController,
                itemCount: OnboardingModel.onboardingList.length,
                itemBuilder: (context, index) => PageViewBody(
                  onboardingModel: OnboardingModel.onboardingList[index],
                ),
              ),
            ),
            CustomSmoothPageIndicator(onboardingManager: onboardingManager),
            SizedBox(height: 30),
            // GeneralButton(
            //   onPressed: () {
            //     context.read<GlobalCubit>().changeTheme(
            //       themeMode: ThemeMode.light,
            //     );
            //   },
            //   text: "Change Theme",
            // ),
            CustomNextWidget(onboardingManager: onboardingManager),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
