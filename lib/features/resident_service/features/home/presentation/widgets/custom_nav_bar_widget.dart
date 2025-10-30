import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/custom_navbar_item.dart';

class CustomNavBarWidget extends StatelessWidget {
  const CustomNavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeResidentCubit>();

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomNavBarItem(
          name: "Home",
          color: cubit.navBarcurrentIndex == 0
              ? AppColors.primaryColor
              : context.isDarkMode
              ? AppColors.whiteColor
              : AppColors.blackColor,
          onPressed: () {
            cubit.updateNavBarCurrentIndex(0);
          },
          icon: Assets.assetsImagesHome,
        ),
        CustomNavBarItem(
          name: "Notification",
          color: cubit.navBarcurrentIndex == 1
              ? AppColors.primaryColor
              : context.isDarkMode
              ? AppColors.whiteColor
              : AppColors.blackColor,
          onPressed: () {
            cubit.updateNavBarCurrentIndex(1);
          },
          icon: Assets.assetsImagesNotification,
        ),
        CustomNavBarItem(
          name: "Cart",
          color: cubit.navBarcurrentIndex == 2
              ? AppColors.primaryColor
              : context.isDarkMode
              ? AppColors.whiteColor
              : AppColors.blackColor,
          onPressed: () {
            cubit.updateNavBarCurrentIndex(2);
          },
          icon: Assets.assetsImagesBookmark,
        ),
        CustomNavBarItem(
          name: "Profile",
          color: cubit.navBarcurrentIndex == 3
              ? AppColors.primaryColor
              : context.isDarkMode
              ? AppColors.whiteColor
              : AppColors.blackColor,
          onPressed: () {
            cubit.updateNavBarCurrentIndex(3);
          },
          icon: Assets.assetsImagesUser,
        ),
      ],
    );
  }
}
