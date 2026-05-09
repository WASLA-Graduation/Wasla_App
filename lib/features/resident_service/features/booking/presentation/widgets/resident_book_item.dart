import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/booking_status.dart';
import 'package:wasla/core/enums/technician_booking_status.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/custom_image_with_stack.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/general_resident_bookings_model.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/manager/cubit/resident_booking_cubit.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/widgets/booking_item_data.dart';

// ignore: must_be_immutable
class ResidentBookItem extends StatelessWidget {
  ResidentBookItem({super.key, required this.model, required this.index});
  final GeneralResidentBookingsModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? AppColors.blackColor.withOpacity(0.2)
            : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
      ),

      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildImageWithStackWidget(imageUrl: model.baseImage),
            const SizedBox(width: 18),
            Expanded(
              child: BlocConsumer<ResidentBookingCubit, ResidentBookingState>(
                buildWhen: (previous, current) =>
                    current is ResidentBookingActions &&
                    current.bookingId == model.baseBookingId,
                listenWhen: (previous, current) =>
                    current is ResidentBookingActions &&
                    current.bookingId == model.baseBookingId,
                listener: (context, state) {
                  if (state is ResidentCancelBookingSuccess) {
                    toastAlert(
                      color: AppColors.primaryColor,
                      msg: 'bookingCaceledSuccess'.tr(context),
                    );
                  } else if (state is ResidentCancelBookingFailure) {
                    toastAlert(color: AppColors.error, msg: state.errMsg);
                  }
                },
                builder: (context, state) {
                  return BookingItemData(
                    index: index,
                    model: model,
                    isUpcoming: cancelWords.contains(model.baseStatus),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> cancelWords = [
    TechnicianBookingStatus.pending.name,
    TechnicianBookingStatus.accepted.name,
    BookingStatus.active.name,
    DoctorBookingStatus.upComing.name,
  ];
}
