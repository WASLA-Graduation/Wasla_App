import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/manager/cubit/resident_driver_cubit.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/widgets/trip_details/trip_details_body.dart';

class DriverTripDetailsView extends StatefulWidget {
  const DriverTripDetailsView({super.key, required this.tripId});
  final int tripId;

  @override
  State<DriverTripDetailsView> createState() => _DriverTripDetailsViewState();
}

class _DriverTripDetailsViewState extends State<DriverTripDetailsView> {
  @override
  void initState() {
    getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text("tripDetails".tr(context)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: const DriverTripDetailsViewBody(),
        ),
      ),
    );
  }

  void getDetails() {
    final cubit = context.read<ResidentDriverCubit>();
    cubit.tripId = widget.tripId;
    cubit.getTripForResident();
  }
}
