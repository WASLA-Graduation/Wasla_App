import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/empty_data_widget.dart';
import 'package:wasla/features/technicant/features/booking/data/models/technicain_booking_model.dart';
import 'package:wasla/features/technicant/features/booking/presentation/manager/cubit/technician_booking_cubit.dart';
import 'package:wasla/features/technicant/features/booking/presentation/widgets/technicain_booking_list_item.dart';

// ignore: must_be_immutable
class TechnicianBookingsList extends StatelessWidget {
  TechnicianBookingsList({super.key});

  List<TechnicainBookingModel> bookings = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TechnicianBookingCubit, TechnicianBookingState>(
      buildWhen: (previous, current) =>
          current is TechincainGetBookingsLoadedState ||
          current is TechincainGetBookingsLoadingState,
      builder: (context, state) {
        if (state is TechincainGetBookingsLoadingState ||
            state is TechincainBookingInitialState) {
          return Center(
            child: SpinKitFadingCircle(color: AppColors.primaryColor, size: 50),
          );
        }
        if (state is TechincainGetBookingsLoadedState) {
          bookings = state.bookings;
        }
        return bookings.isEmpty
            ? EmptyStateWidget(
                title: 'noBookings'.tr(context),
                message: 'noBookingsMsg'.tr(context),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: bookings.length,
                itemBuilder: (context, index) =>
                    TechnicianBookingListItem(technician: bookings[index]),
              );
      },
    );
  }
}
