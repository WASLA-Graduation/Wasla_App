import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/features/resident_service/features/home/data/models/bannar_model.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/custom_bannar_item.dart';

class AllBannarsView extends StatelessWidget {
  const AllBannarsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("spacialOffers".tr(context))),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.marginDefault,
          vertical: AppSizes.paddingSizeDefault,
        ),
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemCount: BannerModel.bannars.length,
          itemBuilder: (context, index) {
            final gradientColors = BannerGradients
                .gradients[index % BannerGradients.gradients.length];

            return Container(
              clipBehavior: Clip.hardEdge,
              padding: const EdgeInsets.only(top: 20),
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(25)),
              ),
              child: CustomBannarItem(banner: BannerModel.bannars[index]),
            );
          },
        ),
      ),
    );
  }
}

class BannerGradients {
  static final List<List<Color>> gradients = [
    [AppColors.primaryColor, AppColors.blue],
    [AppColors.red, AppColors.orange],
    [AppColors.acceptGreen, AppColors.cyan],
    [AppColors.darkbackgroundColor, AppColors.purple],
  ];
}
