import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';

class CategoryServiceModel {
  final String img;
  final String name;
  final Color color;

  CategoryServiceModel({
    required this.img,
    required this.name,
    required this.color,
  });

  static List<CategoryServiceModel> get categories => [
    CategoryServiceModel(
      img: Assets.assetsImagesDumble,
      name: "Gym",
      color: AppColors.purple,
    ),
    CategoryServiceModel(
      img: Assets.assetsImagesCutlery,
      name: "Restaurant",
      color: AppColors.orange,
    ),
    CategoryServiceModel(
      img: Assets.assetsImagesDriver,
      name: "Driver",
      color: AppColors.blue,
    ),
    CategoryServiceModel(
      img: Assets.assetsImagesCustomerSupport,
      name: "Technician",
      color: AppColors.green,
    ),
    CategoryServiceModel(
      img: Assets.assetsImagesDoctor,
      name: "Doctor",
      color: AppColors.cyan,
    ),
    CategoryServiceModel(
      img: Assets.assetsImagesMore,
      name: "More",
      color: AppColors.red,
    ),
  ];
}
