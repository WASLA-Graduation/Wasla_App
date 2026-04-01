import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/manager/cubit/resident_driver_cubit.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/widgets/resident_driver_tracking_body.dart';

class DriverTrackingView extends StatefulWidget {
  const DriverTrackingView({super.key});

  @override
  State<DriverTrackingView> createState() => _DriverTrackingViewState();
}

class _DriverTrackingViewState extends State<DriverTrackingView> {
  @override
  void initState() {
    super.initState();
    startTracking();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ResidentDriverTrackingBody());
  }

  Future<void> startTracking() async {
    final cubit = context.read<ResidentDriverCubit>();
    cubit.lat = cubit.fromPlace!.lat;
    cubit.lng = cubit.fromPlace!.lng;
    // await cubit.getBestRoute();
    // cubit.startDriverSimulation();

    ///for real tracking

    cubit.startLiveTracking();
  }
}
