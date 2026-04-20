import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/restaurant/menu/presentation/widgets/add%20menu/add_menu_item_body.dart';

class AddMenuItemView extends StatelessWidget {
  const AddMenuItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('addMenu'.tr(context))),
      body: const AddMenuItemBody(),
    );
  }
}
