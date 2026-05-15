import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/enums/booking_filter.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/widgets/custom_date_picker_widget.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/custom_choose_time_widget.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/manager/cubit/resident_booking_cubit.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';
import 'package:wasla/features/resident_service/features/restaurant/data/models/Update_restaurant_reservation_model.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/manager/cubit/details/resident_restaurant_cubit.dart';

class ResidentRestaurantReservationViewBody extends StatelessWidget {
  ResidentRestaurantReservationViewBody({
    super.key,
    required this.restaurantId,
    this.reservationModel,
  });
  final String restaurantId;

  final UpdateRestaurantReservationModel? reservationModel;

  final formKey = GlobalKey<FormState>();

  bool get isEdit => reservationModel != null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.marginDefault,
        vertical: AppSizes.paddingSizeSmall,
      ),
      child: Column(
        children: [
          CustomDatePickerWidget(
            currentDate: reservationModel?.reservationDate ?? DateTime.now(),
            onDateChange: (date) => context
                .read<ResidentRestaurantCubit>()
                .updateSelectedDate(date: date),
          ),
          SizedBox(height: AppSizes.paddingSizeDefault),
          BlocBuilder<ResidentRestaurantCubit, ResidentRestaurantState>(
            buildWhen: (previous, current) =>
                current is ResidentRestaurantSelectTimeSlot,
            builder: (context, state) {
              return CustomChooseTimeWidget(
                text: 'time'.tr(context),
                dateChange: (time) {
                  context
                      .read<ResidentRestaurantCubit>()
                      .updateSelectedTimeSlot(time: time);
                },
                selectedTime: context
                    .read<ResidentRestaurantCubit>()
                    .selectedTimeSlot,
              );
            },
          ),
          SizedBox(height: AppSizes.paddingSizeDefault),
          Form(
            key: formKey,
            child: CustomTextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "dataRequired".tr(context);
                }
                int n = int.tryParse(value) ?? 1;
                if (n < 1) {
                  return "dataRequired".tr(context);
                }
                return null;
              },
              initealValue:
                  reservationModel?.numberOfPersons.toString() ?? 1.toString(),
              keyboardTyp: TextInputType.number,
              withTitle: true,
              title: 'numberOfPersons'.tr(context),
              hint: 'numberOfPersons'.tr(context),
              withBorder: true,
              onChanged: (value) {
                context.read<ResidentRestaurantCubit>().numberOfPersons =
                    int.tryParse(value) ?? 1;
              },
            ),
          ),

          const Spacer(),
          BlocConsumer<ResidentRestaurantCubit, ResidentRestaurantState>(
            listener: (context, state) {
              if (state is ResidentRestaurantReservationFailureState) {
                showToast(state.message, color: Colors.red);
              } else if (state is ResidentRestaurantReservationSuccessState) {
                showToast(
                  isEdit
                      ? 'reservationUpdatedSuccessfully'.tr(context)
                      : 'bookingDone'.tr(context),
                  color: Colors.green,
                );

                if (isEdit) {
                  ///for reset
                  context.read<ResidentBookingCubit>().updateBookingTaps(
                    bookingFilter: BookingFilter.technicianBookings,
                  );
                  context.read<HomeResidentCubit>().updateNavBarCurrentIndex(1);
                  context.read<ResidentBookingCubit>().updateBookingTaps(
                    bookingFilter: BookingFilter.restaurantBookings,
                  );
                  context.pushAndRemoveAllScreens(
                    AppRoutes.residenBottomNavBar,
                  );
                } else {
                  context.popScreen();
                }
              }
            },
            builder: (context, state) {
              return GeneralButton(
                onPressed: () {
                  if (state is ResidentRestaurantReservationLoadingState) {
                    return;
                  }

                  if (formKey.currentState!.validate()) {
                    if (isEdit) {
                      context.read<ResidentRestaurantCubit>().updateReservation(
                        reservatoinId: reservationModel!.reservationId,
                      );
                    } else {
                      context
                          .read<ResidentRestaurantCubit>()
                          .reservationWithRestaurant(
                            restaurantId: restaurantId,
                          );
                    }
                  }
                },
                text: state is ResidentRestaurantReservationLoadingState
                    ? 'loading'.tr(context)
                    : isEdit
                    ? "updateReservation".tr(context)
                    : 'bookNow'.tr(context),
              );
            },
          ),
          SizedBox(height: AppSizes.paddingSizeLarge),
        ],
      ),
    );
  }
}
