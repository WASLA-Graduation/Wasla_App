import 'package:wasla/core/utils/assets.dart';

class BannerModel {
  final String title;
  final String subtitle;
  final String description;
  final String image;

  BannerModel({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.image,
  });

  static List<BannerModel> get bannars => [
    BannerModel(
      title: "30%",
      subtitle: "Today's Special",
      description: "Get discount on your first order",
      image: Assets.assetsImagesTest,
    ),
    BannerModel(
      title: "Free",
      subtitle: "Delivery Offer",
      description: "Free delivery for orders above 100 EGP",
      image: Assets.assetsImagesOnboadingThree,
    ),
    BannerModel(
      title: "Hot Deal",
      subtitle: "Limited Time",
      description: "Hurry up! Best offers today only",
      image: Assets.assetsImagesOnboardingOne,
    ),
  ];
  
}
