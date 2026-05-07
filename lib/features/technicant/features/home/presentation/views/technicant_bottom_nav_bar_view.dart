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
import 'package:wasla/features/social_media/presentation/views/all_posts_view.dart';
import 'package:wasla/features/technicant/features/booking/data/repo/technician_bookings_repo_impl.dart';
import 'package:wasla/features/technicant/features/booking/presentation/manager/cubit/technician_booking_cubit.dart';
import 'package:wasla/features/technicant/features/booking/presentation/views/technician_bookings_view.dart';
import 'package:wasla/features/technicant/features/home/presentation/manager/cubit/technicant_dashboard_cubit.dart';
import 'package:wasla/features/technicant/features/home/presentation/views/technician_dashboard_view.dart';

class TechnicantBottomNavBarView extends StatelessWidget {
  const TechnicantBottomNavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TechnicantDashboardCubit, TechnicantDashboardState>(
      buildWhen: (previous, current) => current is ChangeBottomNavBarIndexState,
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
    const TechnicianDashboardView(),
    BlocProvider(
      lazy: true,
      create: (context) => TechnicianBookingCubit(
        TechnicianBookingsRepoImpl(api: sl<ApiConsumer>()),
      ),
      child: TechnicianBookingsView(),
    ),
    const LastUsersViwe(),
    const AllPostsView(),
    const ProfileView(),
  ];

  List<String> getTitles(BuildContext context) => [
    'home'.tr(context),
    'booking'.tr(context),
    'chat'.tr(context),
    'community'.tr(context),

    'profile'.tr(context),
  ];

  List<String> get unSelectedIcons => [
    Assets.assetsImagesHomeOutlined,
    Assets.assetsImagesBookingOutlined,
    Assets.assetsImagesChatOutlined,
    Assets.assetsImagesPeopleOutlined,
    Assets.assetsImagesPersonOutlined,
  ];

  List<String> get selectedIcons => [
    Assets.assetsImagesHomeFilled,
    Assets.assetsImagesBookingFilled,
    Assets.assetsImagesChatFilled,
    Assets.assetsImagesGroup,
    Assets.assetsImagesPeronFilled,
  ];
}
