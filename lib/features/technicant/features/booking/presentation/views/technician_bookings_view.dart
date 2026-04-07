import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
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
      body: const TechnicianBookingBody(),
    );
  }

  void getMyBookings() {}
}
