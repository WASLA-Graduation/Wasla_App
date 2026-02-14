import 'package:flutter/material.dart';
import 'package:wasla/features/gym/features/packages/presentation/widgets/gym_add_update_package_body.dart';

class GymAddUpdatePackageView extends StatelessWidget {
  const GymAddUpdatePackageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add/Update Offer')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: const GymAddUpdatePackageViewBody(),
      ),
    );
  }
}
