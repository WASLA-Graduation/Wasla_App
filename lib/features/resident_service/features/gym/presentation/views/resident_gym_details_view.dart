import 'package:flutter/material.dart';
import 'package:wasla/features/resident_service/features/gym/presentation/widgets/resident_gym_details_body.dart';

class ResidentGymDetailsView extends StatelessWidget {
  const ResidentGymDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gym Details'),
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: const ResidentGymDetailsViewBody(),
      ),
    );
  }
}
