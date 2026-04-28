import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/driver/features/trip/presentation/manager/cubit/driver_trip_cubit.dart';
import 'package:wasla/features/driver/features/trip/presentation/widgets/driver_suggested_trip_info.dart';

class SuggestedTripBody extends StatelessWidget {
  const SuggestedTripBody({super.key, required this.tripId});
  final int tripId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.marginDefault),
      child: Column(
        children: [
          Expanded(child: DriverSuggetedTripInfo(isResidentInfo: false)),
          BlocConsumer<DriverTripCubit, DriverTripState>(
            buildWhen: (previous, current) =>
                current is DriverAcceptRideSuccess ||
                current is DriverAcceptRideFailure ||
                current is DriverAcceptRideLoading,
            listener: (context, state) {
              if (state is DriverAcceptRideSuccess) {
                context.pushScreen(
                  AppRoutes.residentTripInfoScreen,
                  arguments: tripId,
                );
              }
              if (state is DriverAcceptRideFailure) {
                toastAlert(color: AppColors.error, msg: state.errorMessage);
              }
            },
            builder: (context, state) {
              return GeneralButton(
                onPressed: () {
                  context.read<DriverTripCubit>().acceptRide();
                },
                text: state is DriverAcceptRideLoading
                    ? "loading".tr(context)
                    : "acceptTrip".tr(context),
                color: AppColors.acceptGreen,
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
