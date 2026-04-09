import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_styles.dart';
import 'package:wasla/features/technicant/features/booking/presentation/manager/cubit/technician_booking_cubit.dart';

class TechnicianAcceptButton extends StatelessWidget {
  const TechnicianAcceptButton({super.key, required this.bookingId});
  final int bookingId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TechnicianBookingCubit, TechnicianBookingState>(
      listener: (context, state) {
        if (state is TechincainAcceptBookingSuccessState) {
          showToast(
            'bookingAcceptedSuccess'.tr(context),
            color: AppColors.green,
          );
          context.popScreen();
        }

        if (state is TechincainAcceptBookingFailureState) {
          showToast(state.errorMessage, color: AppColors.red);
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: SizeConfig.isTablet ? 58 : 52,
          child: ElevatedButton.icon(
            onPressed: () {
              context
                  .read<TechnicianBookingCubit>()
                  .acceptBookingFromDetailsScreen(bookingId: bookingId);
            },
            icon: const Icon(Icons.check_rounded, size: 20),
            label: Text(
              state is TechincainAcceptBookingLoadingState
                  ? 'loading'.tr(context)
                  : 'acceptBooking'.tr(context),
              style: AppStyles.styleSemiBold16(
                context,
              ).copyWith(color: AppColors.whiteColor),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.whiteColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        );
      },
    );
  }
}
