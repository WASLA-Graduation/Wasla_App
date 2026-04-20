import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/service/service_locator.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/bottom_nav_bar/custom_bottom_nav_bar.dart';
import 'package:wasla/features/chat/presentation/views/last_users_viwe.dart';
import 'package:wasla/features/profile/presentation/views/profile_view.dart';
import 'package:wasla/features/restaurant/home/presentation/manager/cubit/restaurant_dashboard_cubit.dart';
import 'package:wasla/features/restaurant/home/presentation/views/restaurant_dashboard_view.dart';
import 'package:wasla/features/restaurant/menu/data/repo/resident_menu_repo_impl.dart';
import 'package:wasla/features/restaurant/menu/presentation/manager/cubit/resident_menu_cubit.dart';
import 'package:wasla/features/restaurant/menu/presentation/views/menu_view.dart';
import 'package:wasla/features/restaurant/orders/data/presentation/manager/cubit/orders_cubit.dart';
import 'package:wasla/features/restaurant/orders/data/presentation/views/orders_view.dart';
import 'package:wasla/features/restaurant/orders/data/repo/orders_repo_impl.dart';

class RestaurantBottomNavBarView extends StatelessWidget {
  const RestaurantBottomNavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantDashboardCubit, RestaurantDashboardState>(
      buildWhen: (previous, current) =>
          current is RestaurantDashboardUpdateBottomNavBarIndex,
      builder: (context, state) {
        final cubit = context.read<RestaurantDashboardCubit>();
        return Scaffold(
          body: screens[cubit.bottomNabBarIndex],
          bottomNavigationBar: CustomBottomNavBar(
            selectedIndex: cubit.bottomNabBarIndex,
            titles: getTitles(context),
            selectedIcons: selectedIcons,
            unSelectedIcons: unSelectedIcons,
            onIndexChange: (value) {
              cubit.updateBottomNavBarIndex(value);
            },
            onPop: () {
              if (cubit.bottomNabBarIndex != 0) {
                cubit.updateBottomNavBarIndex(0);
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
    RestaurantDashboardView(),
    BlocProvider(
      create: (context) =>
          ResidentMenuCubit(ResidentMenuRepoImpl(api: sl<ApiConsumer>())),
      child: MenuView(),
    ),
    BlocProvider(
      create: (context) => OrdersCubit(OrdersRepoImpl(api: sl<ApiConsumer>())),
      child: OrdersView(),
    ),
    LastUsersViwe(),
    ProfileView(),
  ];

  List<String> getTitles(BuildContext context) => [
    'home'.tr(context),
    'menu'.tr(context),
    'reservation'.tr(context),
    'chat'.tr(context),
    'profile'.tr(context),
  ];

  List<String> get unSelectedIcons => [
    Assets.assetsImagesHomeOutlined,
    Assets.assetsImagesMenuOutLined,
    Assets.assetsImagesTableOutlined,
    Assets.assetsImagesChatOutlined,
    Assets.assetsImagesPersonOutlined,
  ];

  List<String> get selectedIcons => [
    Assets.assetsImagesHomeFilled,
    Assets.assetsImagesMenuFilled,
    Assets.assetsImagesTableFilled,

    Assets.assetsImagesChatFilled,
    Assets.assetsImagesPeronFilled,
  ];
}
