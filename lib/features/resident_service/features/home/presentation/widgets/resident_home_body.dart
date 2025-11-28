import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/features/resident_service/features/home/data/models/category_service_model.dart';
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
        CustomSearchBar(
          onTap: () {
            context.pushScreen(AppRoutes.residentSearchScreen);
          },
        ),
        CustomIdentfierWidget(
          leadingText: "spacialOffers".tr(context),
          actionText: "seeAll".tr(context),
          onTap: () {},
        ),
        CustomBannarWidget(),
        CustomIdentfierWidget(
          leadingText: "services".tr(context),
          actionText: "seeAll".tr(context),
          onTap: () {
            context.pushScreen(AppRoutes.allServicesScreen);
          },
        ),
        CustomServiceCategoryList(
          listLength: CategoryServiceModel.categories.length,
        ),
      ],
    );
  }
}
