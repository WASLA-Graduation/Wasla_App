import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/bottom_nav_bar/custom_navbar_item.dart';

class CustomNavBarWidget extends StatelessWidget {
  const CustomNavBarWidget({
    super.key,
    required this.selectedIndex,
    required this.titles,
    required this.selectedIcons,
    required this.unSelecedIcons,
    required this.changeCurrentIndex,
  });
  final int selectedIndex;
  final List<String> titles, selectedIcons, unSelecedIcons;
  final ValueChanged<int> changeCurrentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        titles.length,
        (index) => CustomNavBarItem(
          name: titles[index],
          color: index == selectedIndex
              ? AppColors.primaryColor
              : AppColors.gray,
          onPressed: () {
            changeCurrentIndex(index);
          },
          icon: index == selectedIndex
              ? selectedIcons[index]
              : unSelecedIcons[index],
        ),
      ),
    );
  }
}
