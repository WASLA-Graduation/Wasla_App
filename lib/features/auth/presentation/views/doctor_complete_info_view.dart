import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';

import 'package:wasla/features/auth/presentation/widgets/complete_info_body.dart';

class DoctorCompleteInfoView extends StatelessWidget {
  const DoctorCompleteInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("completYourProfile".tr(context))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: CompleteInfoBody(),
      ),
    );
  }

}
