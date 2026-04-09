import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/technicant/features/booking/data/models/technicain_booking_model.dart';
import 'package:wasla/features/technicant/features/booking/presentation/widgets/booking%20details/technicain_info_row.dart';

class BookingInfoCard extends StatelessWidget {
  const BookingInfoCard({
    super.key,
    required this.booking,
    required this.isDark,
  });

  final TechnicainBookingModel booking;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.whiteColor.withOpacity(0.05)
            : const Color(0xFFF7FAFF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark
              ? AppColors.whiteColor.withOpacity(0.08)
              : AppColors.primaryColor.withOpacity(0.10),
        ),
      ),
      child: Column(
        children: [
          TechnicainInfoRow(
            icon: Icons.person_rounded,
            label: 'phone'.tr(context),
            value: booking.residentPhone,
            isDark: isDark,
          ),
          _divider(),
          TechnicainInfoRow(
            icon: Icons.location_on_rounded,
            label: 'coordinates'.tr(context),
            value:
                '${booking.latitude.toStringAsFixed(4)}, ${booking.longitude.toStringAsFixed(4)}',
            isDark: isDark,
          ),
          _divider(),
          TechnicainInfoRow(
            icon: Icons.monetization_on_rounded,
            label: 'totalRevenue'.tr(context),
            value: '${booking.price.toStringAsFixed(2)} ${'egb'.tr(context)}',
            isDark: isDark,
            valueColor: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(
      height: 20,
      color: isDark
          ? AppColors.whiteColor.withOpacity(0.07)
          : AppColors.blackColor.withOpacity(0.06),
    );
  }
}
