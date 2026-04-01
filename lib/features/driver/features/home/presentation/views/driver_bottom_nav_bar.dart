import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/driver_status.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/bottom_nav_bar/custom_bottom_nav_bar.dart';
import 'package:wasla/features/chat/presentation/views/last_users_viwe.dart';
import 'package:wasla/features/driver/features/booking/presentation/views/driver_bookings_view.dart';
import 'package:wasla/features/driver/features/home/presentation/manager/cubit/driver_cubit.dart';
import 'package:wasla/features/driver/features/home/presentation/views/driver_dashboard_view.dart';
import 'package:wasla/features/driver/features/trip/presentation/manager/cubit/driver_trip_cubit.dart';
import 'package:wasla/features/profile/presentation/views/profile_view.dart';

class DriverBottomNavBar extends StatefulWidget {
  const DriverBottomNavBar({super.key});

  @override
  State<DriverBottomNavBar> createState() => _DriverBottomNavBarState();

  static List<Widget> screens = [
    DriverDashboardView(),
    DriverBookingsView(),
    LastUsersViwe(),
    const ProfileView(),
  ];
}

class _DriverBottomNavBarState extends State<DriverBottomNavBar>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    updateMyLocation();
    changeMyStatus(DriverStatus.online);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      changeMyStatus(DriverStatus.offline);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverCubit, DriverState>(
      buildWhen: (previous, current) =>
          current is DriverUpdateBottomNabBarIndex,
      builder: (context, state) {
        final cubit = context.read<DriverCubit>();

        return Scaffold(
          body: DriverBottomNavBar.screens[cubit.bottomNabBarIndex],
          bottomNavigationBar: CustomBottomNavBar(
            selectedIndex: cubit.bottomNabBarIndex,
            titles: getTitles(context),
            selectedIcons: selectedIcons,
            unSelectedIcons: unSelectedIcons,
            onIndexChange: (value) {
              cubit.updateBottomNavBarIndex(index: value);
            },
            onPop: () {
              if (cubit.bottomNabBarIndex != 0) {
                cubit.updateBottomNavBarIndex(index: 0);
              } else {
                SystemNavigator.pop();
              }
            },
          ),
        );
      },
    );
  }

  List<String> getTitles(BuildContext context) => [
    'home'.tr(context),
    'booking'.tr(context),
    'chat'.tr(context),
    'profile'.tr(context),
  ];

  List<String> get unSelectedIcons => [
    Assets.assetsImagesHomeOutlined,
    Assets.assetsImagesBookingOutlined,
    Assets.assetsImagesChatOutlined,
    Assets.assetsImagesPersonOutlined,
  ];

  List<String> get selectedIcons => [
    Assets.assetsImagesHomeFilled,
    Assets.assetsImagesBookingFilled,
    Assets.assetsImagesChatFilled,
    Assets.assetsImagesPeronFilled,
  ];

  void updateMyLocation() {
    context.read<DriverTripCubit>().sendDriverLocatonToBackEnd();
  }

  void changeMyStatus(DriverStatus driverStatus) {
    context.read<DriverTripCubit>().updateDriverStatus(
      driverStatus: driverStatus,
    );
  }
}
