import 'package:flutter/material.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/widgets/custom_resident_booking_taps.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/widgets/resident_booking_list.dart';

class ResidentBookingBody extends StatelessWidget {
  const ResidentBookingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: CustomResidentBookingTaps()),
        SliverToBoxAdapter(child: const SizedBox(height: 15)),
        ResidentBookingList(),
      ],
    );
  }
}
