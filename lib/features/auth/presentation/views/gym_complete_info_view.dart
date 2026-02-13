import 'package:flutter/material.dart';
import 'package:wasla/features/auth/presentation/widgets/gym_complete_info_body.dart';

class GymCompleteInfoView extends StatelessWidget {
  const GymCompleteInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GymCompleteInfoBody(),
      ),
    );
  }
}
