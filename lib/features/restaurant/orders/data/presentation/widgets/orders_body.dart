import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_sizes.dart';

class OrdersBody extends StatelessWidget {
  const OrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.marginDefault),
      child: Center(child: Text("Orders")),
    );
  }
}
