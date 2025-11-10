import 'package:flutter/material.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/features/auth/presentation/widgets/choose_auth_body.dart';

class ChooseAuthView extends StatelessWidget {
  const ChooseAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 5),
        child: ChooseAuthBody(),
      ),
    );
  }
}

