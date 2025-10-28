import 'package:flutter/material.dart';
import 'package:wasla/core/utils/size_config.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/custom_bannar_widget.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/custom_home_app_bar.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/custom_identfier_widget.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/custom_search_bar.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/custom_service_category_list.dart';

class ResidentHomeBody extends StatelessWidget {
  const ResidentHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(
        left: SizeConfig.blockWidth * 6,
        right: SizeConfig.blockWidth * 6,
        top: SizeConfig.blockHeight * 6,
        bottom: 0,
      ),
      children: [
        const CustomHomeAppBar(),
        const SizedBox(height: 20),
        const CustomSearchBar(),
        const CustomIdentfierWidget(
          leadingText: "Spacial Offers",
          actionText: "See All",
        ),
        CustomBannarWidget(),
        const CustomIdentfierWidget(
          leadingText: "Services",
          actionText: "See All",
        ),
        CustomServiceCategoryList(),
      ],
    );
  }
}
