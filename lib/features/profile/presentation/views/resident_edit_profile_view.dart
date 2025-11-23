import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/resident_service/features/home/data/models/user_model.dart';
import 'package:wasla/features/profile/presentation/widgets/resident_edit_profile_body.dart';

class ResidentEditProfileView extends StatelessWidget {
  const ResidentEditProfileView({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("edit_profile".tr(context))),
      body: ResidentEditProfileBody(user: user),
    );
  }
}
