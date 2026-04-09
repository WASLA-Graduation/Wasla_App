import 'package:flutter/material.dart';
import 'package:wasla/core/enums/technician_booking_status.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/features/technicant/features/booking/data/models/technicain_booking_model.dart';
import 'package:wasla/features/technicant/features/booking/presentation/widgets/booking%20details/technician_accept_button.dart';
import 'package:wasla/features/technicant/features/booking/presentation/widgets/booking%20details/technician_booking_info_card.dart';
import 'package:wasla/features/technicant/features/booking/presentation/widgets/booking%20details/technician_resident_card.dart';
import 'package:wasla/features/technicant/features/booking/presentation/widgets/booking%20details/technician_stats_row.dart';

class TechicianBookingBody extends StatelessWidget {
  const TechicianBookingBody({
    super.key,
    required this.booking,
    required this.isDark,
  });

  final TechnicainBookingModel booking;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final double h = SizeConfig.isTablet ? 20.0 : 14.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.isTablet ? 32 : 20),
      child: Column(
        children: [
          TechnicianResidentCard(booking: booking, isDark: isDark),
          TechnicianStatsRow(booking: booking, isDark: isDark),
          BookingInfoCard(booking: booking, isDark: isDark),
          SizedBox(height: h * 1.5),
          booking.status == TechnicianBookingStatus.pending
              ? TechnicianAcceptButton(bookingId: booking.bookingId)
              : const SizedBox(),
          SizedBox(height: h * 1.5),
        ],
      ),
    );
  }
}
