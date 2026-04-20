import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/widgets/bloc_status_handler.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/custom_doc_add_service_float_button.dart';
import 'package:wasla/features/restaurant/menu/presentation/manager/cubit/menu_cubit.dart';
import 'package:wasla/features/restaurant/menu/presentation/widgets/menu_body.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  void initState() {
    super.initState();
    getMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFloatingAddButton(onPressed: () {}),
      appBar: AppBar(title: Text('menu'.tr(context))),
      body: BlocStatusHandler<MenuCubit, MenuState>(
        body: const MenuBody(),
        onRetry: () {
          getMenu();
          context.read<MenuCubit>().onRetry();
        },
        isNetwork: (state) => state is GetMenuNetWorkState,
        isError: (state) => state is GetMenuFailureState,
        buildWhen: (previous, current) =>
            current is GetMenuNetWorkState ||
            current is GetMenuFailureState ||
            current is OnRetryState,
      ),
    );
  }

  void getMenu() {
    // final cubit = context.read<MenuCubit>();
  }
}
