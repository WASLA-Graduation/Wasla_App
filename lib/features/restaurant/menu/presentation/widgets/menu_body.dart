import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_sizes.dart';

class MenuBody extends StatelessWidget {
  const MenuBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.marginDefault),
      child: Center(child: Text("Menu")),
    );
  }
}
