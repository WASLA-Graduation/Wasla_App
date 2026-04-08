import 'package:flutter/material.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/features/technicant/features/booking/presentation/widgets/technician_booking_taps.dart';

class TechnicianBookingBody extends StatelessWidget {
  const TechnicianBookingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final double space = SizeConfig.isDesktop ? 25 : 15;
    final double paddingVert = SizeConfig.isDesktop ? 15 : 7;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: space, vertical: paddingVert),
      child: Column(spacing: space, children: [TechnicianBookingsTaps()]),
    );
  }
}
