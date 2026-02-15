import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/gym/features/packages/presentation/widgets/gym_add_update_package_form.dart';

class GymAddUpdatePackageViewBody extends StatelessWidget {
  const GymAddUpdatePackageViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: GymAddUpdatePackageForm()),
        const SizedBox(height: 20),
        GeneralButton(onPressed: () {}, text: 'addPackage'.tr(context)),
        const SizedBox(height: 20),
      ],
    );
  }
}
