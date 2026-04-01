import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/driver/features/home/data/models/driver_profile_model.dart';
import 'package:wasla/features/profile/presentation/widgets/driver_edit_profile_body.dart';

class DirverEditProfileView extends StatelessWidget {
  const DirverEditProfileView({super.key, required this.profile});
  final DriverProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text("edit_profile".tr(context)),
      ),
      body: DriverEditProfileBody(driver: profile),
    );
  }
}
