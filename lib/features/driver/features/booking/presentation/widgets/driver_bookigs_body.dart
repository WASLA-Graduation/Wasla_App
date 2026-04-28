import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/empty_data_widget.dart';
import 'package:wasla/features/driver/features/booking/presentation/manager/cubit/driver_booking_cubit.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/general_resident_bookings_model.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/widgets/resident_book_item.dart';

class DriverBookigsBody extends StatefulWidget {
  const DriverBookigsBody({super.key});

  @override
  State<DriverBookigsBody> createState() => _DriverBookigsBodyState();
}

class _DriverBookigsBodyState extends State<DriverBookigsBody> {
  List<GeneralResidentBookingsModel> bookings = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverBookingCubit, DriverBookingState>(
      buildWhen: (previous, current) =>
          current is DriverGetBookingsLoading ||
          current is DriverGetBookingsSuccess,
      builder: (context, state) {
        if (state is DriverGetBookingsLoading ||
            state is DriverBookingInitial) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        } else if (state is DriverGetBookingsSuccess) {
          bookings = state.allBookings;
          return bookings.isEmpty
              ? EmptyStateWidget(
                  title: 'noBookings'.tr(context),
                  message: 'noBookingsMsg'.tr(context),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  itemCount: bookings.length,
                  itemBuilder: (_, index) =>
                      ResidentBookItem(model: bookings[index], index: index),
                );
        }
        return SizedBox.shrink();
      },
    );
  }
}
