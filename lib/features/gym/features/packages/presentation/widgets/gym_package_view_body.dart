import 'package:flutter/material.dart';
import 'package:wasla/features/gym/features/packages/presentation/widgets/gym_package_taps.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/widgets/packages_offers_list.dart';

class GymPackageViewBody extends StatelessWidget {
  const GymPackageViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GymPackageOffersTaps(),
        const SizedBox(height: 25),

        Expanded(child: PackagesOffersList()),
      ],
    );
  }
}
