import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/features/auth/presentation/widgets/restaurant/restaurant_complete_info_catergory.dart';
import 'package:wasla/features/auth/presentation/widgets/restaurant/restaurant_complete_info_form.dart';
import 'package:wasla/features/auth/presentation/widgets/restaurant/restaurant_complete_info_galary.dart';
import 'package:wasla/features/auth/presentation/widgets/restaurant/restaurant_image.dart';

class RestaurantCompleteInfoList extends StatelessWidget {
  const RestaurantCompleteInfoList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const RestaurantImage(),
        SizedBox(height: AppSizes.paddingSizeDefault),
        const RestaurantCompleteInfoForm(),
        SizedBox(height: AppSizes.paddingSizeDefault),
        const RestaurantCompleteInfoCategory(),
        SizedBox(height: AppSizes.paddingSizeDefault),
        const RestaurantCompleteInfoGalary(),
        SizedBox(height: AppSizes.paddingSizeDefault),
      ],
    );
  }
}
