import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
          child: SuggestedTripBody(tripId: widget.tripId),
        ),
      ),
    );
  }

  void getTripDetails() {
    //TODO in future

    final cubit = context.read<DriverTripCubit>();
    cubit.tripId = widget.tripId;
    cubit.tripIdStored = widget.tripId;
    cubit.tripDetails = null;
    cubit.getRideDetails();
  }
}
