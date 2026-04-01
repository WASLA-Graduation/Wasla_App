import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/auth/presentation/widgets/resturent_info_body.dart';

class ResurentInfoView extends StatelessWidget {
  const ResurentInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("fillResturentData".tr(context))),
      body: ResturentInfoBody(),
    );
  }
}
