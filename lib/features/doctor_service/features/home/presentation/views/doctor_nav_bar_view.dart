import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/bottom_nav_bar/custom_bottom_nav_bar.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/manager/cubit/doctor_home_cubit.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/views/service_view.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/custom_doc_add_service_float_button.dart';
import 'package:wasla/features/profile/presentation/views/profile_view.dart';

class DoctorNavBarView extends StatelessWidget {
  const DoctorNavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorHomeCubit, DoctorHomeState>(
      builder: (context, state) {
        final cubit = context.read<DoctorHomeCubit>();

        return Scaffold(
          floatingActionButton: cubit.navBarCurrentIndex == 1
              ? CustomAddDoctorServiceButton()
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
    Container(),
    ServiceView(),
    Container(),
    const ProfileView(),
  ];

  List<String> getTitles(BuildContext context) => [
    'home'.tr(context),
    'service'.tr(context),
    'chat'.tr(context),
    'profile'.tr(context),
  ];

  List<String> get unSelectedIcons => [
    Assets.assetsImagesHomeOutlined,
    Assets.assetsImagesDoctorKitOutlined,
    Assets.assetsImagesChatOutlined,
    Assets.assetsImagesPersonOutlined,
  ];

  List<String> get selectedIcons => [
    Assets.assetsImagesHomeFilled,
    Assets.assetsImagesDoctorKitFilled,
    Assets.assetsImagesChatFilled,
    Assets.assetsImagesPeronFilled,
  ];
}
