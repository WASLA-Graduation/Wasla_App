import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/restaurant/menu/presentation/manager/cubit/resident_menu_cubit.dart';
import 'package:wasla/features/restaurant/menu/presentation/widgets/add%20menu/add_menu_item_body.dart';

class AddMenuItemView extends StatefulWidget {
  const AddMenuItemView({super.key});

  @override
  State<AddMenuItemView> createState() => _AddMenuItemViewState();
}

class _AddMenuItemViewState extends State<AddMenuItemView> {
  @override
  void initState() {
    resert();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('addMenu'.tr(context))),
      body: const AddMenuItemBody(),
    );
  }

  void resert() {
    context.read<ResidentMenuCubit>().reset();
  }
}
