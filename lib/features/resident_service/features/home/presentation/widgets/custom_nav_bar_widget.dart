import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              : AppColors.gray,

          onPressed: () {
            
            cubit.updateNavBarCurrentIndex(0);
          },
          icon: cubit.navBarcurrentIndex == 0
              ? Assets.assetsImagesHomeFilled
              : Assets.assetsImagesHomeOutlined,
        ),
        CustomNavBarItem(
          name: "Booking",
          color: cubit.navBarcurrentIndex == 1
              ? AppColors.primaryColor
              : AppColors.gray,
          onPressed: () {
            cubit.updateNavBarCurrentIndex(1);
          },
          icon: cubit.navBarcurrentIndex == 1
              ? Assets.assetsImagesBookingFilled
              : Assets.assetsImagesBookingOutlined,
        ),
        CustomNavBarItem(
          name: "Chat",
          color: cubit.navBarcurrentIndex == 2
              ? AppColors.primaryColor
              : AppColors.gray,
          onPressed: () {
            cubit.updateNavBarCurrentIndex(2);
          },
          icon: cubit.navBarcurrentIndex == 2
              ? Assets.assetsImagesChatFilled
              : Assets.assetsImagesChatOutlined,
        ),
        CustomNavBarItem(
          name: "Profile",
          color: cubit.navBarcurrentIndex == 3
              ? AppColors.primaryColor
              : AppColors.gray,
          onPressed: () {
            cubit.updateNavBarCurrentIndex(3);
          },
          icon: cubit.navBarcurrentIndex == 3
              ? Assets.assetsImagesPeronFilled
              : Assets.assetsImagesPersonOutlined,
        ),
      ],
    );
  }
}
