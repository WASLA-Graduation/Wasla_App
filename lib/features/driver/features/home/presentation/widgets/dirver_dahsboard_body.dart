import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/features/driver/features/home/presentation/widgets/driver_appbar_widget.dart';
import 'package:wasla/features/driver/features/home/presentation/widgets/get_driver_statisitcs.dart';

class DirverDahsboardBody extends StatelessWidget {
  const DirverDahsboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.marginDefault,
        vertical: AppSizes.paddingSizeExtraSmall,
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: const DriverAppBar()),
          SliverToBoxAdapter(child: const SizedBox(height: 20)),
          const GetDriverStatisitcs(),
        ],
      ),
    );
  }
}
