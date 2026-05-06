import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/auth/presentation/widgets/restaurant/restuarant_complete_info_body.dart';

class RestaurantCompleteInfoView extends StatelessWidget {
  const RestaurantCompleteInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('completYourProfile'.tr(context))),
      body:const  RestaurantCompleteInfoBody(),
    );
  }
}
