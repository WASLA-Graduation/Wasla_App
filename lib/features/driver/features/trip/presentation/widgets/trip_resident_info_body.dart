import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/driver/features/trip/presentation/manager/cubit/driver_trip_cubit.dart';
import 'package:wasla/features/driver/features/trip/presentation/widgets/driver_suggested_trip_info.dart';

class TripResidentInfoBody extends StatelessWidget {
  const TripResidentInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: DriverSuggetedTripInfo(isResidentInfo: true)),
        BlocConsumer<DriverTripCubit, DriverTripState>(
          listener: (context, state) {
            if (state is DriverStartRideFailure) {
              toastAlert(color: AppColors.error, msg: state.errorMessage);
            }
            if (state is DriverCompleteRideFailure) {
              toastAlert(color: AppColors.error, msg: state.errorMessage);
            }
            if (state is DriverCompleteRideSuccess) {
              context.pushAndRemoveAllScreens(
                AppRoutes.driverBottomNavBarScreen,
              );
            }
          },
          buildWhen: (previous, current) =>
              current is DriverWhenArrived ||
              current is DriverStrartRideSuccess ||
              current is DriverStartRideLoading ||
              current is DriverCompleteRideLoading ||
              current is DriverStartRideFailure ||
              current is DriverCompleteRideFailure,

          builder: (context, state) {
            final cubit = context.read<DriverTripCubit>();

            return cubit.isDriverArrived
                ? cubit.isStartedTrip
                      ? GeneralButton(
                          onPressed: () {
                            cubit.compelteRide();
                          },
                          text: state is DriverCompleteRideLoading
                              ? 'loading'.tr(context)
                              : 'completeTrip'.tr(context),
                          color: AppColors.acceptGreen,
                        )
                      : GeneralButton(
                          onPressed: () {
                            cubit.startRide();
                          },
                          text: state is DriverStartRideLoading
                              ? 'tripLoading'.tr(context)
                              : 'startTrip'.tr(context),
                          color: AppColors.acceptGreen,
                        )
                : DriverCancelTripReqButton();
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class DriverCancelTripReqButton extends StatelessWidget {
  const DriverCancelTripReqButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverTripCubit, DriverTripState>(
      buildWhen: (previous, current) =>
          current is DriverCancelRideLoading ||
          current is DriverCancelRideSuccess ||
          current is DriverCancelRideFailure,
      listener: (context, state) {
        if (state is DriverCancelRideSuccess) {
          showToast(color: AppColors.primaryColor, 'tripCancelled'.tr(context));
          context.pushAndRemoveAllScreens(AppRoutes.driverBottomNavBarScreen);
        }

        if (state is DriverCancelRideFailure) {
          toastAlert(color: AppColors.error, msg: state.errorMessage);
        }
      },
      builder: (context, state) {
        return GeneralButton(
          color: AppColors.error,
          text: state is DriverCancelRideLoading
              ? 'loading'.tr(context)
              : 'cancelTrip'.tr(context),
          onPressed: () {
            context.read<DriverTripCubit>().cancelRide();
          },
        );
      },
    );
  }
}
