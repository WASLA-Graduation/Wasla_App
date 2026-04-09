import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/error_widget.dart';
import 'package:wasla/core/widgets/internet/no_internet_widget.dart';
import 'package:wasla/features/technicant/features/booking/data/models/technicain_booking_model.dart';
import 'package:wasla/features/technicant/features/booking/presentation/manager/cubit/technician_booking_cubit.dart';
import 'package:wasla/features/technicant/features/booking/presentation/widgets/booking%20details/technician_booking_body.dart';
import 'package:wasla/features/technicant/features/booking/presentation/widgets/booking%20details/technician_booking_header.dart';

class TechnicianBookingDetailsView extends StatefulWidget {
  final int bookingId;

  const TechnicianBookingDetailsView({super.key, required this.bookingId});

  @override
  State<TechnicianBookingDetailsView> createState() =>
      _TechnicianBookingDetailsViewState();
}

class _TechnicianBookingDetailsViewState
    extends State<TechnicianBookingDetailsView> {
  TechnicainBookingModel? booking;
  @override
  void initState() {
    getBookingDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDarkMode;

    return Scaffold(
      body: BlocBuilder<TechnicianBookingCubit, TechnicianBookingState>(
        buildWhen: (previous, current) =>
            current is! TechincainAcceptBookingSuccessState &&
            current is! TechincainAcceptBookingFailureState &&
            current is! TechincainAcceptBookingLoadingState,
        builder: (context, state) {
          if (state is TechincainBookingNetworkState) {
            return NoInternetWidget(
              onRetry: () {
                getBookingDetails();
              },
            );
          } else if (state is TechincainBookingFailureState) {
            return MyErrorWidget(
              onRetry: () {
                getBookingDetails();
              },
            );
          } else if (state is TechincainGetBookingDetailsLoadingState ||
              state is TechincainBookingInitialState) {
            return Center(
              child: SpinKitFadingCircle(
                color: AppColors.primaryColor,
                size: 50,
              ),
            );
          } else if (state is TechincainGetBookingDetailsLoadedState) {
            booking = state.booking;
            return PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) {
                if (!didPop) {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.pushReplacementScreen(
                      AppRoutes.technicantBottomNavBarScreen,
                    );
                  }
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TechnicianBookingHeader(booking: booking!, isDark: isDark),
                    TechicianBookingBody(booking: booking!, isDark: isDark),
                  ],
                ),
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  void getBookingDetails() {
    context.read<TechnicianBookingCubit>().getBookingDatails(
      bookingId: widget.bookingId,
    );
  }
}
