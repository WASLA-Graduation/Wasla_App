import 'package:flutter/material.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/widgets/resident_all_booking_catergory_filter.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/widgets/resident_all_booking_list.dart';

class ResidentAllBookingsViewBody extends StatelessWidget {
  const ResidentAllBookingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 6,),
        ResidentAllBookingsCategoryFilter(),
        Expanded(child: ResidentAllBookingsList()),
      ],
    );
  }
}
