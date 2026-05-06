import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/profile/presentation/widgets/restaurant/restaurant_edit_profile_body.dart';
import 'package:wasla/features/restaurant/home/data/models/restaurant_model.dart';

class RestaurantEditProfile extends StatelessWidget {
  const RestaurantEditProfile({super.key, required this.restaurant});
  final RestaurantModel restaurant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('edit_profile'.tr(context))),
      body:  RestaurantEditProfileBody(restaurantModel: restaurant),
    );
  }
}
