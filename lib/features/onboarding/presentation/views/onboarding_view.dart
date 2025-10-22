import 'package:flutter/material.dart';
import 'package:wasla/features/onboarding/presentation/widgets/onboarding_body.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: OnboardingBody(),
      ),
    );
  }
}
