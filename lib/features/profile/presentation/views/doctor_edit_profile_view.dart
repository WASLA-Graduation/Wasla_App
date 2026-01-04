import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_model.dart';
import 'package:wasla/features/profile/presentation/widgets/doc_edit_profile_body.dart';

class DoctorEditProfileView extends StatelessWidget {
  const DoctorEditProfileView({super.key, required this.doc});
  final DoctorModel doc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text("edit_profile".tr(context)),
      ),
      body: DocEditProfileBody(doc: doc),
    );
  }
}
