import 'package:flutter/material.dart';
import 'package:wasla/core/models/user_model.dart';
import 'package:wasla/features/profile/presentation/widgets/resident_edit_profile_body.dart';

class ResidentEditProfileView extends StatelessWidget {
  const ResidentEditProfileView({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: ResidentEditProfileBody(user: user),
    );
  }
}
