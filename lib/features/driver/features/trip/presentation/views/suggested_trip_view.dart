import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/widgets/bloc_status_handler.dart';
import 'package:wasla/features/driver/features/trip/presentation/manager/cubit/driver_trip_cubit.dart';
import 'package:wasla/features/driver/features/trip/presentation/widgets/suggested_trip_body.dart';

class SuggestedTripView extends StatefulWidget {
  const SuggestedTripView({super.key, required this.tripId});

  final int tripId;

  @override
  State<SuggestedTripView> createState() => _SuggestedTripViewState();
}

class _SuggestedTripViewState extends State<SuggestedTripView> {
  @override
  void initState() {
    getTripDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocStatusHandler<DriverTripCubit, DriverTripState>(
          body: SuggestedTripBody(tripId: widget.tripId),
          onRetry: () {
            getTripDetails();
            context.read<DriverTripCubit>().onRetry();
          },
          isNetwork: (state) => state is DriverTripNetworkState,
          isError: (state) => state is DriverTripFailureState,
          buildWhen: (previous, current) =>
              current is DriverTripNetworkState ||
              current is DriverTripFailureState ||
              current is DriverTripOnRetryState,
        ),
      ),
    );
  }

  void getTripDetails() async {
    final cubit = context.read<DriverTripCubit>();
    // await cubit.fetchDriverLocation();
    cubit.tripId = widget.tripId;
    cubit.tripIdStored = widget.tripId;
    cubit.tripDetails = null;
    cubit.getRideDetails();
  }
}
