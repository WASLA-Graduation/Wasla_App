import 'package:wasla/core/utils/assets.dart';

class ProfileItemModel {
  final String image;
  final String title;
  final String route;

  const ProfileItemModel({
    required this.image,
    required this.title,
    required this.route,
  });

  static const List<ProfileItemModel> items = [
    ProfileItemModel(
      image: Assets.assetsImagesPersonOutlined,
      title: "Edit Profile",
      route: "",
    ),
    ProfileItemModel(
      image: Assets.assetsImagesNotification,
      title: "Notification",
      route: "",
    ),
    ProfileItemModel(
      image: Assets.assetsImagesPayment,
      title: "Payment",
      route: "",
    ),
    ProfileItemModel(
      image: Assets.assetsImagesSecurity,
      title: "Security",
      route: "",
    ),
    ProfileItemModel(
      image: Assets.assetsImagesVision,
      title: "Dark Mode",
      route: "",
    ),
    ProfileItemModel(
      image: Assets.assetsImagesLock,
      title: "Privacy Policy",
      route: "",
    ),
    ProfileItemModel(
      image: Assets.assetsImagesHelp,
      title: "Help Center",
      route: "",
    ),
  ];
}
