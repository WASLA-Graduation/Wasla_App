import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/resident_service/features/restaurant/data/models/restauarant_menu_item_model.dart';
import 'package:wasla/features/restaurant/menu/presentation/widgets/add%20menu/add_menu_item_body.dart';

class UpdateMenuItemView extends StatelessWidget {
  const UpdateMenuItemView({super.key, required this.menu});
  final MenuItem menu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('updateMenu'.tr(context))),
      body: AddMenuItemBody(menu: menu),
    );
  }
}
