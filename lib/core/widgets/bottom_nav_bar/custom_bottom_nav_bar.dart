import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/bottom_nav_bar/custom_nav_bar_widget.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final List<String> titles;
  final List<String> selectedIcons;
  final List<String> unSelectedIcons;
  final Function(int index) onIndexChange;
  final VoidCallback onPop;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.titles,
    required this.selectedIcons,
    required this.unSelectedIcons,
    required this.onIndexChange,
    required this.onPop,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: selectedIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        onPop();
      },
      child: BottomAppBar(
        color: Theme.of(context).scaffoldBackgroundColor,
        height: 90,
        elevation: 0.3,
        surfaceTintColor: AppColors.primaryColor,
        child: CustomNavBarWidget(
          selectedIndex: selectedIndex,
          titles: titles,
          selectedIcons: selectedIcons,
          unSelecedIcons: unSelectedIcons,
          changeCurrentIndex: onIndexChange,
        ),
      ),
    );
  }
}
