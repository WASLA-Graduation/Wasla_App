import 'package:flutter/material.dart';
import 'package:wasla/features/technicant/features/booking/presentation/widgets/technicain_booking_list_item.dart';

class TechnicianBookingsList extends StatelessWidget {
  const TechnicianBookingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: 10,
      itemBuilder: (context, index) => const TechnicianBookingListItem(),
    );
  }
}
