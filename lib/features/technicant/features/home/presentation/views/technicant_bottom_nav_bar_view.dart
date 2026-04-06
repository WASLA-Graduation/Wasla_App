import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/bottom_nav_bar/custom_bottom_nav_bar.dart';
import 'package:wasla/features/technicant/features/home/presentation/manager/cubit/technicant_dashboard_cubit.dart';
import 'package:wasla/features/technicant/features/home/presentation/views/technician_dashboard_view.dart';

class TechnicantBottomNavBarView extends StatelessWidget {
  const TechnicantBottomNavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TechnicantDashboardCubit, TechnicantDashboardState>(
      builder: (context, state) {
        final cubit = context.read<TechnicantDashboardCubit>();

        return Scaffold(
          body: screens[cubit.bottomNabBarIndex],
          bottomNavigationBar: CustomBottomNavBar(
            selectedIndex: cubit.bottomNabBarIndex,
            titles: getTitles(context),
            selectedIcons: selectedIcons,
            unSelectedIcons: unSelectedIcons,
            onIndexChange: (value) {
              cubit.changeBottomNavBarIndex(value);
            },
            onPop: () {
              if (cubit.bottomNabBarIndex != 0) {
                cubit.changeBottomNavBarIndex(0);
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
    TechnicianDashboardView(),
    Container(),
    Container(),
    Container(),
  ];

  List<String> getTitles(BuildContext context) => [
    'home'.tr(context),
    'requests'.tr(context),
    'chat'.tr(context),
    'profile'.tr(context),
  ];

  List<String> get unSelectedIcons => [
    Assets.assetsImagesHomeOutlined,
    Assets.assetsImagesPeopleOutlined,
    Assets.assetsImagesChatOutlined,
    Assets.assetsImagesPersonOutlined,
  ];

  List<String> get selectedIcons => [
    Assets.assetsImagesHomeFilled,
    Assets.assetsImagesPeopleFilled,
    Assets.assetsImagesChatFilled,
    Assets.assetsImagesPeronFilled,
  ];
}
