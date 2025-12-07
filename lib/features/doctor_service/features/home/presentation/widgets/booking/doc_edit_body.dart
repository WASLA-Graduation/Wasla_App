import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/format_time_with_intl.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/custom_date_picker_widget.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_booking_model.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/manager/cubit/doctor_home_cubit.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/custom_choose_time_widget.dart';

class DocEditBookingBody extends StatelessWidget {
  const DocEditBookingBody({super.key, required this.bookingModel});
  final DoctorBookingModel bookingModel;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorHomeCubit>();
    return BlocConsumer<DoctorHomeCubit, DoctorHomeState>(
      listener: (context, state) {
        if (state is DoctorUpdateBookingFailure) {
          toastAlert(color: AppColors.error, msg: state.errorMessage);
        } else if (state is DoctorUpdateBookingSuccess) {
          toastAlert(
            color: AppColors.primaryColor,
            msg: "bookingSuccess".tr(context),
          );
          context.popScreen();
        }
      },
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                spacing: 20,
                children: [
                  CustomDatePickerWidget(
                    currentDate: convertStringToDateTime(bookingModel.date),
                    onDateChange: (date) => cubit.currentChoosenDate = date,
                  ),
                  CustomChooseTimeWidget(
                    text: "from".tr(context),
                    selectedTime: cubit.currentChoosenFromTime!,
                    dateChange: (value) {
                      cubit.currentChoosenFromTime = value;
                      cubit.updateTime();
                    },
                  ),
                  CustomChooseTimeWidget(
                    text: "to".tr(context),
                    selectedTime: cubit.currentChoosenToTime!,
                    dateChange: (value) {
                      cubit.currentChoosenToTime = value;
                      cubit.updateTime();
                    },
                  ),
                  const Spacer(),
                  GeneralButton(
                    onPressed: () async {
                      await cubit.updateBooking(booking: bookingModel);
                    },
                    text: state is DoctorUpdateBookingLoading
                        ? "loading".tr(context)
                        : "save".tr(context),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
