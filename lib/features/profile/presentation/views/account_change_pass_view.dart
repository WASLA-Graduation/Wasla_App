import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/profile/presentation/widgets/account_change_pass_body.dart';

class AccountChangePassView extends StatelessWidget {
  const AccountChangePassView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("changePassword".tr(context))),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20,20,20,0),
        child: AccountChangePassBody(),
      ),
    );
  }
}
