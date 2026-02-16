import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/profile/data/models/gym_model.dart';
import 'package:wasla/features/profile/presentation/widgets/gym_edit_profile_body.dart';

class GymEditProfileView extends StatelessWidget {
  const GymEditProfileView({super.key, required this.gym});
  final GymModel gym;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text('editProfile'.tr(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: GymEditProfileBody(gym: gym),
      ),
    );
  }
}
