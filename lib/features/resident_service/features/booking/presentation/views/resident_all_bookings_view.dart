import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/manager/cubit/resident_booking_cubit.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/widgets/resident_all_bookings_body.dart';

class ResidentAllBookingsView extends StatefulWidget {
  const ResidentAllBookingsView({super.key});

  @override
  State<ResidentAllBookingsView> createState() =>
      _ResidentAllBookingsViewState();
}

class _ResidentAllBookingsViewState extends State<ResidentAllBookingsView> {
  @override
  void initState() {
    getResidentBookings();
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
      body: ResidentAllBookingsViewBody(),
    );
  }

  void getResidentBookings() async {
    context.read<ResidentBookingCubit>().resetState();
    context.read<ResidentBookingCubit>().getAllBookingsByStatus();
  }
}
