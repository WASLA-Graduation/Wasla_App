import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/driver/features/booking/presentation/manager/cubit/driver_booking_cubit.dart';
import 'package:wasla/features/driver/features/booking/presentation/widgets/driver_bookigs_body.dart';

class DriverBookingsView extends StatefulWidget {
  const DriverBookingsView({super.key});

  @override
  State<DriverBookingsView> createState() => _DriverBookingsViewState();
}

class _DriverBookingsViewState extends State<DriverBookingsView> {
  @override
  void initState() {
    getMyBookings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: Text(
          "myBookings".tr(context),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),

      body: const DriverBookigsBody(),
    );
  }

  void getMyBookings() {
    context.read<DriverBookingCubit>().getDriverBookings();
  }
}
