import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/booking_filter.dart';
import 'package:wasla/core/enums/restauant_reservation_status.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/general_resident_bookings_model.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/manager/cubit/resident_booking_cubit.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/widgets/custom_resdient_canceld_button.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/widgets/custom_update_booking_reservation.dart';

class BookingItemData extends StatelessWidget {
  const BookingItemData({
    super.key,
    required this.isUpcoming,
    required this.model,
    required this.index,
  });
  final bool isUpcoming;
  final GeneralResidentBookingsModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 6,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleWidget(context),
        _buildSpecialityWidget(context),
        _buildDateAndTimeWidget(context),
      ],
    );
  }

  Row _buildSpecialityWidget(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            "${model.baseServiceName} ",
            style: Theme.of(
              context,
            ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
          ),
        ),
        Text(
          " |   ${model.baseStatus.tr(context)} ",
          style: Theme.of(
            context,
          ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
        ),
      ],
    );
  }

  Row _buildTitleWidget(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Expanded(
          child: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            model.baseName,
            style: Theme.of(
              context,
            ).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        CustomResidentCancelButton(
          isUpcoming: isUpcoming,
          bookingId: model.baseBookingId,
          index: index,
        ),
      ],
    );
  }

  Column _buildDateAndTimeWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 3,
      children: [
        Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          model.baseDate!,
          style: Theme.of(
            context,
          ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
        ),
        Row(
          spacing: 10,

          children: [
            Expanded(
              child: Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                model.baseDuration!,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
              ),
            ),

            if (model.baseStatus == ReservationStatus.pending.name &&
                context.read<ResidentBookingCubit>().bookingFilter ==
                    BookingFilter.restaurantBookings)
              CustomUpdateReservationButton(model: model),
          ],
        ),
      ],
    );
  }
}
