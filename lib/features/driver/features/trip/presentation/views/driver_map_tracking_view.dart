import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:wasla/features/driver/features/trip/presentation/manager/cubit/driver_trip_cubit.dart';
import 'package:wasla/features/driver/features/trip/presentation/widgets/driver_tracking_body.dart';

class DriverMapTrackingView extends StatefulWidget {
  const DriverMapTrackingView({super.key});

  @override
  State<DriverMapTrackingView> createState() => _DriverMapTrackingViewState();
}

class _DriverMapTrackingViewState extends State<DriverMapTrackingView> {
  @override
  void initState() {
    super.initState();
    startTracking();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) =>
            context.read<DriverTripCubit>().stopLiveTracking(),
        child: DriverTrackingBody(),
      ),
    );
  }

  void startTracking() async {
    log('Disha');
    final cubit = context.read<DriverTripCubit>();
    cubit.initializeTrip().then((_) {
      cubit.passengerLocation = LatLng(
        cubit.tripDetails!.pickUpLatitude,
        cubit.tripDetails!.pickUpLongitude,
      );
      cubit.startLiveTracking();
    });
  }
}
