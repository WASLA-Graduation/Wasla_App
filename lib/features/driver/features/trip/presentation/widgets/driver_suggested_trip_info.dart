import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/helpers/url_helper.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/driver/features/trip/data/models/driver_trip_and_resident_info_model.dart';
import 'package:wasla/features/driver/features/trip/presentation/manager/cubit/driver_trip_cubit.dart';
import 'package:wasla/features/driver/features/trip/presentation/widgets/suggested_trip_data_box.dart';
import 'package:wasla/features/driver/features/trip/presentation/widgets/suggested_trip_header.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/widgets/trip_details/driver_card_info_source_dest.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/widgets/trip_details/show_driver_track_tile.dart';

class DriverSuggetedTripInfo extends StatelessWidget {
  const DriverSuggetedTripInfo({super.key, required this.isResidentInfo});
  final bool isResidentInfo;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DriverTripCubit>();
    return BlocBuilder<DriverTripCubit, DriverTripState>(
      buildWhen: (previous, current) =>
          current is DriverGetRideDeatialsSuccess ||
          current is DriverGetRideDeatialsLoading,

      builder: (context, state) {
        if (state is DriverGetRideDeatialsLoading ||
            state is DriverTripInitial ||
            cubit.tripDetails == null) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.acceptGreen,
              size: 50.0,
            ),
          );
        } else {
          return Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: context.isDarkMode ? Colors.grey.shade800 : Colors.white,
              borderRadius: BorderRadius.circular(7),
            ),
            child: _TripData(
              isResidentInfo: isResidentInfo,
              trip: cubit.tripDetails!,
            ),
          );
        }
      },
    );
  }
}

class _TripData extends StatelessWidget {
  const _TripData({required this.isResidentInfo, required this.trip});

  final bool isResidentInfo;
  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    // context.read<DriverTripCubit>().passengerLocation = LatLng(
    //   trip.pickUpLatitude,
    //   trip.pickUpLongitude,
    // );
    return Column(
      children: [
        SuggestTripHeader(image: trip.residentImage, name: trip.residentName),
        Divider(height: 15, thickness: 0.5, color: Colors.grey.shade300),
        Visibility(
          visible: isResidentInfo,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  UrlHelper.callPhone(trip.residentPhone);
                },
                child: SuggestedTripBoxData(
                  title: 'phone'.tr(context),
                  data: trip.residentPhone,
                ),
              ),
              Divider(height: 25, thickness: 0.5, color: Colors.grey.shade300),
            ],
          ),
        ),
        DriverCardInfoSourceDest(
          destination: trip.dropOffPlace,
          destinationDate: trip.dropOffTime,
          source: trip.pickUpPlace,
          sourceDate: trip.pickUpTime,
        ),
        Divider(height: 25, thickness: 0.5, color: Colors.grey.shade300),
        SuggestedTripBoxData(
          title: 'distance'.tr(context),
          data: '${trip.distance} km',
        ),
        Divider(height: 25, thickness: 0.5, color: Colors.grey.shade300),
        SuggestedTripBoxData(
          title: 'duration'.tr(context),
          data: '${trip.duration.toStringAsFixed(0)} min',
        ),
        Divider(height: 25, thickness: 0.5, color: Colors.grey.shade300),
        SuggestedTripBoxData(
          title: 'price'.tr(context),
          data: '${trip.price.toStringAsFixed(0)} ${"egb".tr(context)}',
        ),
        Visibility(
          visible: isResidentInfo,
          child: Column(
            children: [
              Divider(height: 25, thickness: 0.5, color: Colors.grey.shade300),
              BlocBuilder<DriverTripCubit, DriverTripState>(
                buildWhen: (previous, current) => current is DriverWhenArrived,
                builder: (context, state) {
                  return ShowDriverTrackTile(
                    showMap: !context.read<DriverTripCubit>().isDriverArrived,
                    route: AppRoutes.driverMapTrackingScreen,
                    title: 'showPassenLocation',
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
