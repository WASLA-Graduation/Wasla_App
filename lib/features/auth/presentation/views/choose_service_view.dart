import 'package:flutter/material.dart';

import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/features/auth/presentation/widgets/choose_service_body.dart';

class ChooseServiceView extends StatelessWidget {
  const ChooseServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockWidth * 6,
          vertical: SizeConfig.blockHeight * 8,
        ),
        child: ChooseServiceBody(),
      ),
    );
  }
}
