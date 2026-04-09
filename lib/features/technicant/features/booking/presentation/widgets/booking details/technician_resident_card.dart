import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_styles.dart';
import 'package:wasla/core/widgets/custom_circle_network_image.dart';
import 'package:wasla/features/technicant/features/booking/data/models/technicain_booking_model.dart';
import 'package:wasla/features/technicant/features/booking/presentation/widgets/booking%20details/technician_phone_button.dart';

class TechnicianResidentCard extends StatelessWidget {
  const TechnicianResidentCard({
    super.key,
    required this.booking,
    required this.isDark,
  });

  final TechnicainBookingModel booking;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -28),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkbackgroundColor : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark
                ? AppColors.whiteColor.withOpacity(0.08)
                : AppColors.primaryColor.withOpacity(0.12),
          ),
          boxShadow: isDark
              ? []
              : [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          children: [
            CircleNeworkImage(
              imageUrl: booking.residentImage,
              isLoading: false,
              size: SizeConfig.isTablet ? 64 : 53,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.residentName,
                    style: AppStyles.styleSemiBold16(context).copyWith(
                      color: isDark
                          ? AppColors.whiteColor
                          : AppColors.blackColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'resident'.tr(context),
                    style: AppStyles.smallDesdcriptionStyle.copyWith(
                      color: isDark
                          ? AppColors.whiteColor.withOpacity(0.45)
                          : AppColors.gray,
                    ),
                  ),
                ],
              ),
            ),
            TechnicianPhoneButton(phone: booking.residentPhone, isDark: isDark),
          ],
        ),
      ),
    );
  }
}
