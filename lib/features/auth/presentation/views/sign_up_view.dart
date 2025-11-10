import 'package:flutter/material.dart';

import 'package:wasla/core/responsive/size_config.dart';

import 'package:wasla/features/auth/presentation/widgets/sign_up_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 5),
        child: SignUpBody(),
      ),
    );
  }
}
