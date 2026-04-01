import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/functions/get_right_route.dart';
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

  static List<ProfileItemModel> get items => [
    ProfileItemModel(
      image: Assets.assetsImagesEditProfile,
      title: "editProfile",
      route: getRightEditProfileRoute(),
    ),
    ProfileItemModel(
      image: Assets.assetsImagesPersonOutlined,
      title: "profileInformation",
      route: getRightPersonalInfoRoute(),
    ),
    const ProfileItemModel(
      image: Assets.assetsImagesNotification,
      title: "notification",
      route: "",
    ),
    const ProfileItemModel(
      image: Assets.assetsImagesPayment,
      title: "payment",
      route: "",
    ),
    const ProfileItemModel(
      image: Assets.assetsImagesLanguage,
      title: "language",
      route: AppRoutes.chnageLangScreen,
    ),
    const ProfileItemModel(
      image: Assets.assetsImagesVision,
      title: "darkMode",
      route: "",
    ),
    const ProfileItemModel(
      image: Assets.assetsImagesLock,
      title: "privacyPolicy",
      route: "",
    ),
    const ProfileItemModel(
      image: Assets.assetsImagesHelp,
      title: "helpCenter",
      route: "",
    ),
  ];
}
