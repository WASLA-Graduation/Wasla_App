import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/gym/features/packages/data/models/gym_package_model.dart';
import 'package:wasla/features/gym/features/packages/presentation/manager/cubit/gym_packages_cubit.dart';
import 'package:wasla/features/gym/features/packages/presentation/widgets/gym_add_update_package_body.dart';

class GymAddUpdatePackageView extends StatefulWidget {
  const GymAddUpdatePackageView({super.key, this.package});
  final GymPackageModel? package;

  @override
  State<GymAddUpdatePackageView> createState() =>
      _GymAddUpdatePackageViewState();
}

class _GymAddUpdatePackageViewState extends State<GymAddUpdatePackageView> {
  @override
  void initState() {
    resetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit() ? "updatePackage".tr(context) : "addPackage".tr(context),
        ),
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
        child: GymAddUpdatePackageViewBody(package: widget.package),
      ),
    );
  }

  bool isEdit() {
    return widget.package != null;
  }

  void resetData() {
    context.read<GymPackagesCubit>().resetData();
  }
}
