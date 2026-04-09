import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/technicant/features/booking/data/models/technicain_booking_model.dart';
import 'package:wasla/features/technicant/features/booking/presentation/widgets/booking%20details/technician_stat_card.dart';

class TechnicianStatsRow extends StatelessWidget {
  const TechnicianStatsRow({
    super.key,
    required this.booking,
    required this.isDark,
  });

  final TechnicainBookingModel booking;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -14),
      child: Row(
        children: [
          Expanded(
            child: StatCard(
              icon: Icons.calendar_month_rounded,
              label: 'date'.tr(context),
              value:
                  '${booking.bookingDate.day} ${_monthName(booking.bookingDate.month).tr(context)}',
              subValue: '${booking.bookingDate.year}',
              isDark: isDark,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: StatCard(
              icon: Icons.access_time_rounded,
              label: 'time'.tr(context),
              value:
                  '${booking.bookingDate.hour.toString().padLeft(2, '0')}:${booking.bookingDate.minute.toString().padLeft(2, '0')}',
              subValue: booking.bookingDate.hour >= 12 ? 'PM' : 'AM',
              isDark: isDark,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: StatCard(
              icon: Icons.attach_money_rounded,
              label: 'price'.tr(context),
              value: booking.price.toStringAsFixed(0),
              subValue: 'egb'.tr(context),
              isDark: isDark,
              valueColor: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      'month_1',
      'month_2',
      'month_3',
      'month_4',
      'month_5',
      'month_6',
      'month_7',
      'month_8',
      'month_9',
      'month_10',
      'month_11',
      'month_12',
    ];
    return months[month - 1];
  }
}
