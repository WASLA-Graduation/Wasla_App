import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/auth/presentation/widgets/doctor_info_body.dart';

class DoctorInfoView extends StatelessWidget {
  const DoctorInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,

        title: Text("fillYourProfile".tr(context)),
      ),
      body: DoctorInfoBody(),
    );
  }
}
