import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/widgets/error_widget.dart';
import 'package:wasla/core/widgets/internet/no_internet_widget.dart';
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
        scrolledUnderElevation: 0,
        title: Text(
          "myBookings".tr(context),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: BlocBuilder<ResidentBookingCubit, ResidentBookingState>(
        buildWhen: (previous, current) =>
            current is ResidentBookingNetwrok ||
            current is ResidentBookingOnRetry ||
            current is ResidentGetBookingsFailure,
        builder: (context, state) {
          final cubit = context.read<ResidentBookingCubit>();
          if (state is ResidentBookingNetwrok) {
            return NoInternetWidget(
              onRetry: () {
                cubit.whenRetry();
                cubit.getAllBookingsByStatus();
              },
            );
          } else if (state is ResidentGetBookingsFailure) {
            return MyErrorWidget(
              onRetry: () {
                cubit.whenRetry();
                cubit.getAllBookingsByStatus();
              },
            );
          }
          return ResidentAllBookingsViewBody();
        },
      ),
    );
  }

  void getResidentBookings() async {
    context.read<ResidentBookingCubit>().getAllBookingsByStatus();
  }
}
