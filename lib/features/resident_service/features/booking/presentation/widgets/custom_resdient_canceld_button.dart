import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/custom_bottom_sheet_confirm_widget.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/manager/cubit/resident_booking_cubit.dart';

class CustomResidentCancelButton extends StatelessWidget {
  const CustomResidentCancelButton({
    super.key,
    required this.isUpcoming,
    required this.index,
    required this.bookingId,
  });

  final bool isUpcoming;
  final int bookingId;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResidentBookingCubit, ResidentBookingState>(
      listener: (context, state) {
        if (state is ResidentCancelBookingSuccess) {
          toastAlert(
            color: AppColors.primaryColor,
            msg: 'bookingCaceledSuccess'.tr(context),
          );
        } else if (state is ResidentCacelBookingFailure) {
          toastAlert(color: AppColors.error, msg: state.errMsg);
        }
      },
      builder: (context, state) {
        return Visibility(
          visible: isUpcoming,
          child: InkWell(
            onTap: () async {
              showModalBottomSheet(
                context: context,
                builder: (_) => CustomBottomSheetConfirmWidget(
                  cancelText: 'cancel'.tr(context),
                  confirmText: 'confirm'.tr(context),
                  onConfirm: () {
                    Navigator.pop(context);
                    context.read<ResidentBookingCubit>().cancelBooking(
                      bookingId: bookingId,
                      index: index,
                    );
                  },
                  title: 'cancelBooking'.tr(context),
                  description: 'areYouSureCancel'.tr(context),
                ),
              );
            },
            child: Container(
              width: 60,
              height: 25,
              decoration: ShapeDecoration(
                color: AppColors.primaryColor,
                shape: StadiumBorder(),
              ),

              child: Center(
                child: Text(
                  "cancel".tr(context),
                  style: TextStyle(fontSize: 12, color: AppColors.whiteColor),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
