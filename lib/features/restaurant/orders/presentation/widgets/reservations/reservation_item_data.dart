import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/restauant_reservation_status.dart';
import 'package:wasla/core/functions/format_date_from_string.dart';
import 'package:wasla/core/functions/format_time_with_intl.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/restaurant/orders/data/model/restaurant_reservation_model.dart';
import 'package:wasla/features/restaurant/orders/presentation/manager/cubit/orders_cubit.dart';
import 'package:wasla/features/technicant/features/booking/presentation/widgets/technicain_booking_cancel_button.dart';

class OrderReservationItemData extends StatelessWidget {
  const OrderReservationItemData({super.key, required this.reservation});
  final RestaurantReservationModel reservation;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 6,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleWidget(context),
        _buildSpecialityWidget(context),
        _buildDateAndTimeWidget(context),
        _buildCancelButtonWidget(context),
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
            '${reservation.numberOfPersons} ${"persons".tr(context)}',
            style: Theme.of(
              context,
            ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
          ),
        ),
        Text(
          " |  ${reservation.status.name.tr(context)} ",
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
            reservation.name,
            style: Theme.of(
              context,
            ).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        BlocConsumer<OrdersCubit, OrdersState>(
          buildWhen: (previous, current) =>
              current is ChangeReservationStatusState &&
              current.reservationId == reservation.id,

          listenWhen: (previous, current) =>
              current is ChangeReservationStatusState &&
              current.reservationId == reservation.id,
          listener: (context, state) {
            if (state is AcceptReservationStatusSuccessState) {
              showToast(
                'reservationAccepted'.tr(context),
                color: AppColors.green,
              );
            }

            if (state is AcceptReservationStatusFailureState) {
              showToast(state.errorMessage, color: AppColors.red);
            }
          },
          builder: (context, state) {
            final cubit = context.read<OrdersCubit>();

            return Visibility(
              visible: reservation.status == ReservationStatus.pending,
              child: TechnicianBookingCancelOrAcceptButton(
                isCancel: false,
                text: "accept".tr(context),
                color: AppColors.primaryColor,
                onTap: () async {
                  await cubit.changeReservationStatus(
                    status: ReservationStatus.accepted,
                    reservationId: reservation.id,
                  );

                  reservation.status = ReservationStatus.accepted;
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Row _buildDateAndTimeWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 3,
            children: [
              Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                '${formatDateBooking(reservation.reservationDate)} | ${convertBackendTimeToAmPm(reservation.reservationTime)}',
                style: Theme.of(
                  context,
                ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row _buildCancelButtonWidget(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Expanded(
          child: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            reservation.phone,
            style: Theme.of(
              context,
            ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
          ),
        ),
        BlocConsumer<OrdersCubit, OrdersState>(
          buildWhen: (previous, current) =>
              current is ChangeReservationStatusState &&
              current.reservationId == reservation.id,

          listenWhen: (previous, current) =>
              current is ChangeReservationStatusState &&
              current.reservationId == reservation.id,
          listener: (context, state) {
            if (state is CancelReservationStatusSuccessState) {
              showToast(
                'reservationCancelled'.tr(context),
                color: AppColors.green,
              );
            }

            if (state is CancelReservationStatusFailureState) {
              showToast(state.errorMessage, color: AppColors.red);
            }
          },
          builder: (context, state) {
            return Visibility(
              visible:
                  reservation.status == ReservationStatus.pending ||
                  reservation.status == ReservationStatus.accepted,

              child: TechnicianBookingCancelOrAcceptButton(
                isCancel: true,
                text: "cancel".tr(context),
                color: AppColors.red,
                onTap: () {
                  context.read<OrdersCubit>().changeReservationStatus(
                    status: ReservationStatus.canceled,
                    reservationId: reservation.id,
                  );

                  reservation.status = ReservationStatus.canceled;
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
