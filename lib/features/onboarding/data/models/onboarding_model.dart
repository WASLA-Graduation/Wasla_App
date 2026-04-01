import 'package:wasla/core/utils/assets.dart';

class OnboardingModel {
  final String image;
  final String description;

  OnboardingModel({required this.image, required this.description});

  static final List<OnboardingModel> onboardingList = [
    OnboardingModel(
      image: Assets.assetsImagesOnboardingOne,
      description: "onboardingOneDesc",
    ),
    OnboardingModel(
      image: Assets.assetsImagesOnboardingTwo,
      description: "onboardingTwoDesc",
    ),
    OnboardingModel(
      image: Assets.assetsImagesOnboadingThree,
      description: "onboardingThreeDesc",
    ),
  ];
}
