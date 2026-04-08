import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/widgets/error_widget.dart';
import 'package:wasla/core/widgets/internet/no_internet_widget.dart';
import 'package:wasla/features/technicant/features/booking/presentation/manager/cubit/technician_booking_cubit.dart';
import 'package:wasla/features/technicant/features/booking/presentation/widgets/technician_bookings_body.dart';

class TechnicianBookingsView extends StatefulWidget {
  const TechnicianBookingsView({super.key});

  @override
  State<TechnicianBookingsView> createState() => _TechnicianBookingsViewState();
}

class _TechnicianBookingsViewState extends State<TechnicianBookingsView> {
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
        scrolledUnderElevation: 0,
        title: Text(
          "myBookings".tr(context),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: BlocBuilder<TechnicianBookingCubit, TechnicianBookingState>(
        buildWhen: (previous, current) =>
            current is TechincainBookingNetworkState ||
            current is TechincainBookingOnRetryState ||
            current is TechincainBookingFailureState,
        builder: (context, state) {
          if (state is TechincainBookingNetworkState) {
            return NoInternetWidget(
              onRetry: () {
                context.read<TechnicianBookingCubit>().whenRetry();
                getMyBookings();
              },
            );
          } else if (state is TechincainBookingFailureState) {
            return MyErrorWidget(
              onRetry: () {
                context.read<TechnicianBookingCubit>().whenRetry();
                getMyBookings();
              },
            );
          } else {
            return TechnicianBookingBody();
          }
        },
      ),
    );
  }

  void getMyBookings() {
    final cubit = context.read<TechnicianBookingCubit>();
    cubit.getBookings();
  }
}
