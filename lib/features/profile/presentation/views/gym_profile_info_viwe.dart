import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/profile/data/models/gym_model.dart';
import 'package:wasla/features/profile/presentation/widgets/gym_profile_info_body.dart';

class GymProfileInfoViwe extends StatelessWidget {
  const GymProfileInfoViwe({super.key, required this.gym});
  final GymModel gym;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('profileInformation'.tr(context))),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: GymProfileInfoViweBody(gym: gym),
      ),
    );
  }
}
