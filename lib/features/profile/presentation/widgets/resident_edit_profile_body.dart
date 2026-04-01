import 'package:flutter/material.dart';
import 'package:wasla/features/resident_service/features/home/data/models/user_model.dart';
import 'package:wasla/features/profile/presentation/widgets/custom_resident_edit_form.dart';

class ResidentEditProfileBody extends StatelessWidget {
  const ResidentEditProfileBody({super.key, required this.user});
    final UserModel user;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: CustomResidetnEditInfoForm(user:user),
          ),
        ],
      ),
    );
  }
}

