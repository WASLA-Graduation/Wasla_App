import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/auth/presentation/widgets/technicant/technicant_complete_info_body.dart';

class TechnicantCompleteInfoView extends StatelessWidget {
  const TechnicantCompleteInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text('completYourProfile'.tr(context)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: const TechnicantCompleteInfoBody(),
      ),
    );
  }
}
