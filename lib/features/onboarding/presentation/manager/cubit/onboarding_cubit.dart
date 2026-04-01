import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/onboarding/data/models/onboarding_model.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());
  final PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  void nextPage() {
    if (currentIndex != OnboardingModel.onboardingList.length - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void updateCurrentIndex(int index) {
    currentIndex = index;
    emit(OnboardingUpdate());
  }
}
