import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/widgets/custom_date_picker_widget.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/custom_choose_time_widget.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/manager/cubit/details/resident_restaurant_cubit.dart';

class ResidentRestaurantReservationViewBody extends StatelessWidget {
  const ResidentRestaurantReservationViewBody({
    super.key,
    required this.restaurantId,
  });
  final String restaurantId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.marginDefault),
      child: Column(
        children: [
          CustomDatePickerWidget(
            currentDate: DateTime.now(),
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
          CustomTextFormField(
            initealValue: context
                .read<ResidentRestaurantCubit>()
                .numberOfPersons
                .toString(),
            keyboardTyp: TextInputType.number,
            withTitle: true,
            title: 'numberOfPersons'.tr(context),
            hint: 'numberOfPersons'.tr(context),
            withBorder: true,
            onChanged: (value) {
              context.read<ResidentRestaurantCubit>().numberOfPersons =
                  int.parse(value);
            },
          ),

          const Spacer(),
          BlocConsumer<ResidentRestaurantCubit, ResidentRestaurantState>(
            listener: (context, state) {
              if (state is ResidentRestaurantReservationFailureState) {
                showToast(state.message, color: Colors.red);
              } else if (state is ResidentRestaurantReservationSuccessState) {
                showToast('bookingDone'.tr(context), color: Colors.green);
                context.popScreen();
              }
            },
            builder: (context, state) {
              return GeneralButton(
                onPressed: () {
                  if (state is ResidentRestaurantReservationLoadingState) {
                    return;
                  }
                  context
                      .read<ResidentRestaurantCubit>()
                      .reservationWithRestaurant(restaurantId: restaurantId);
                },
                text: state is ResidentRestaurantReservationLoadingState
                    ? 'loading'.tr(context)
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
