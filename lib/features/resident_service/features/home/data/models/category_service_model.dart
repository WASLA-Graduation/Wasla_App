import 'package:flutter/material.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';

class CategoryServiceModel {
  final String img;
  final String name;
  final Color color;
  final String route;

  CategoryServiceModel({
    required this.route,
    required this.img,
    required this.name,
    required this.color,
  });

  static List<CategoryServiceModel> get categories => [
    CategoryServiceModel(
      route: '',
      img: Assets.assetsImagesDumble,
      name: "Gym",
      color: AppColors.purple,
    ),
    CategoryServiceModel(
      route: '',

      img: Assets.assetsImagesCutlery,
      name: "Restaurant",
      color: AppColors.orange,
    ),
    CategoryServiceModel(
      route: '',

      img: Assets.assetsImagesDriver,
      name: "Driver",
      color: AppColors.blue,
    ),
    CategoryServiceModel(
      route: '',

      img: Assets.assetsImagesCustomerSupport,
      name: "Technician",
      color: AppColors.green,
    ),
    CategoryServiceModel(
      route: AppRoutes.doctorScreen,
      img: Assets.assetsImagesDoctor,
      name: "Doctor",
      color: AppColors.cyan,
    ),
  ];
}
