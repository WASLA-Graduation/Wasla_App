import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/bottom_nav_bar/custom_bottom_nav_bar.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/custom_doc_add_service_float_button.dart';
import 'package:wasla/features/gym/features/dashboard/presentation/manager/cubit/gym_dashboard_cubit.dart';
import 'package:wasla/features/gym/features/dashboard/presentation/views/gym_dashboard_view.dart';
import 'package:wasla/features/gym/features/packages/presentation/views/gym_packages_view.dart';

class GymBottomNavBar extends StatelessWidget {
  const GymBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GymDashboardCubit, GymDashboardState>(
      builder: (context, state) {
        final cubit = context.read<GymDashboardCubit>();

        return Scaffold(
          floatingActionButton: cubit.bottomNavBarcurrentIndex == 1
              ? CustomFloatingAddButton(
                  onPressed: () {
                    context.pushScreen(AppRoutes.gymAddUpdatePackageScreen);
                  },
                )
              : null,
          body: screens[cubit.bottomNavBarcurrentIndex],
          bottomNavigationBar: CustomBottomNavBar(
            selectedIndex: cubit.bottomNavBarcurrentIndex,
            titles: getTitles(context),
            selectedIcons: selectedIcons,
            unSelectedIcons: unSelectedIcons,
            onIndexChange: (value) {
              cubit.updateNavBarCurrentIndex(value);
            },
            onPop: () {
              if (cubit.bottomNavBarcurrentIndex != 0) {
                cubit.updateNavBarCurrentIndex(0);
              } else {
                SystemNavigator.pop();
              }
            },
          ),
        );
      },
    );
  }

  static List<Widget> screens = [
    GymDashboardView(),
    GymPackagesView(),
    Container(),
    Container(),
    // const ProfileView(),
  ];

  List<String> getTitles(BuildContext context) => [
    'home'.tr(context),
    'packages'.tr(context),
    'chat'.tr(context),
    'profile'.tr(context),
  ];

  List<String> get unSelectedIcons => [
    Assets.assetsImagesHomeOutlined,
    Assets.assetsImagesDumbbleOutlined,
    Assets.assetsImagesChatOutlined,
    Assets.assetsImagesPersonOutlined,
  ];

  List<String> get selectedIcons => [
    Assets.assetsImagesHomeFilled,
    Assets.assetsImagesDumbbellFilled,
    Assets.assetsImagesChatFilled,
    Assets.assetsImagesPeronFilled,
  ];
}
