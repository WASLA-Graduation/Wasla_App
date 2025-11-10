import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';

import 'package:wasla/features/auth/presentation/widgets/complete_info_body.dart';

// ignore: must_be_immutable
class DoctorCompleteInfoView extends StatelessWidget {
  DoctorCompleteInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("completYourProfile".tr(context))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: CompleteInfoBody(items: items),
      ),
    );
  }

  List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];
}
