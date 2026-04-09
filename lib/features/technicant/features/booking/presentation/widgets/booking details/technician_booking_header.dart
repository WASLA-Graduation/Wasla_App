import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_styles.dart';
import 'package:wasla/features/technicant/features/booking/data/models/technicain_booking_model.dart';

class TechnicianBookingHeader extends StatelessWidget {
  const TechnicianBookingHeader({
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
      padding: EdgeInsets.fromLTRB(
        SizeConfig.isTablet ? 32 : 24,
        MediaQuery.of(context).padding.top + (SizeConfig.isTablet ? 36 : 28),
        SizeConfig.isTablet ? 32 : 24,
        SizeConfig.isTablet ? 72 : 56,
      ),
      color: AppColors.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'bookingDetails'.tr(context),
            style: AppStyles.styleBold25(context).copyWith(
              color: AppColors.whiteColor,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.whiteColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              booking.status.name,
              style: AppStyles.smallDesdcriptionStyle.copyWith(
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}