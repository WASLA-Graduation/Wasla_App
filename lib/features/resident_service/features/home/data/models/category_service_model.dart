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
      route: AppRoutes.gymResidentScreen,
      img: Assets.assetsImagesDumble,
      name: "gym",
      color: AppColors.purple,
    ),
    CategoryServiceModel(
      route: '',

      img: Assets.assetsImagesCutlery,
      name: "restaurant",
      color: AppColors.orange,
    ),
    CategoryServiceModel(
      route: '',

      img: Assets.assetsImagesDriver,
      name: "driver",
      color: AppColors.blue,
    ),
    CategoryServiceModel(
      route: '',

      img: Assets.assetsImagesCustomerSupport,
      name: "technician",
      color: AppColors.green,
    ),
    CategoryServiceModel(
      route: AppRoutes.doctorScreen,
      img: Assets.assetsImagesDoctor,
      name: "doctor",
      color: AppColors.cyan,
    ),
  ];
}
