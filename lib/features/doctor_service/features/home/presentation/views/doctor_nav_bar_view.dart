import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/bottom_nav_bar/custom_bottom_nav_bar.dart';
import 'package:wasla/features/chat/presentation/views/last_users_viwe.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/manager/cubit/doctor_home_cubit.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/views/doctor_dashboard_view.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/views/service_view.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/custom_doc_add_service_float_button.dart';
import 'package:wasla/features/profile/presentation/views/profile_view.dart';
import 'package:wasla/features/social_media/presentation/views/all_posts_view.dart';

class DoctorNavBarView extends StatelessWidget {
  const DoctorNavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorHomeCubit, DoctorHomeState>(
      builder: (context, state) {
        final cubit = context.read<DoctorHomeCubit>();

        return Scaffold(
          floatingActionButton: cubit.navBarCurrentIndex == 1
              ? CustomFloatingAddButton(
                  onPressed: () {
                    context.pushScreen(AppRoutes.doctorAddServiceScreen);
                  },
                )
              : null,
          body: screens[cubit.navBarCurrentIndex],
          bottomNavigationBar: CustomBottomNavBar(
            selectedIndex: cubit.navBarCurrentIndex,
            titles: getTitles(context),
            selectedIcons: selectedIcons,
            unSelectedIcons: unSelectedIcons,
            onIndexChange: (value) {
              cubit.updateNavBarCurrentIndex(value);
            },
            onPop: () {
              if (cubit.navBarCurrentIndex != 0) {
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
    const DoctorDashboardView(),
    const ServiceView(),
    const LastUsersViwe(),
    const AllPostsView(),

    const ProfileView(),
  ];

  List<String> getTitles(BuildContext context) => [
    'home'.tr(context),
    'service'.tr(context),
    'chat'.tr(context),
    'community'.tr(context),
    'profile'.tr(context),
  ];

  List<String> get unSelectedIcons => [
    Assets.assetsImagesHomeOutlined,
    Assets.assetsImagesDoctorKitOutlined,
    Assets.assetsImagesChatOutlined,
    Assets.assetsImagesPeopleOutlined,
    Assets.assetsImagesPersonOutlined,
  ];

  List<String> get selectedIcons => [
    Assets.assetsImagesHomeFilled,
    Assets.assetsImagesDoctorKitFilled,
    Assets.assetsImagesChatFilled,
    Assets.assetsImagesGroup,
    Assets.assetsImagesPeronFilled,
  ];
}
