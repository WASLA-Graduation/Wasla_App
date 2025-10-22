import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/size_config.dart';
import 'package:wasla/features/auth/presentation/widgets/reset_pass_body.dart';

class ResetPassView extends StatelessWidget {
  const ResetPassView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("createNewPassword".tr(context))),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 5),
        child: ResetPassBody(),
      ),
    );
  }
}
