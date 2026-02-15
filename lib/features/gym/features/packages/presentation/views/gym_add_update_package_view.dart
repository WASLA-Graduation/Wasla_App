import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/gym/features/packages/presentation/widgets/gym_add_update_package_body.dart';

class GymAddUpdatePackageView extends StatelessWidget {
  const GymAddUpdatePackageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("addPackage".tr(context)),
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
        child: const GymAddUpdatePackageViewBody(),
      ),
    );
  }
}
