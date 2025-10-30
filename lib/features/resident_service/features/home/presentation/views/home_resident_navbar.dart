import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';
import 'package:wasla/features/resident_service/features/home/presentation/views/resident_home_view.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/custom_nav_bar_widget.dart';

class HomeResidentNavbar extends StatelessWidget {
  const HomeResidentNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeResidentCubit, HomeResidentState>(
      builder: (context, state) {
        return Scaffold(
          body: screens[context.read<HomeResidentCubit>().navBarcurrentIndex],
          bottomNavigationBar: BottomAppBar(
            color: context.isDarkMode
                ? AppColors.darkbackgroundColor
                : AppColors.whiteColor,
            height: 90,
            elevation: 10,

            child: CustomNavBarWidget(),
          ),
        );
      },
    );
  }

  static List<Widget> screens = [
    const ResidentHomeView(),
    Container(),
    Container(),
    Container(),
  ];
}
