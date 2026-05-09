import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/empty_data_widget.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/manager/cubit/resident_booking_cubit.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/widgets/resident_book_item.dart';

class ResidentAllBookingsList extends StatelessWidget {
  const ResidentAllBookingsList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResidentBookingCubit>();
    return BlocBuilder<ResidentBookingCubit, ResidentBookingState>(
      buildWhen: (previous, current) =>
          current is ResidentAllGetBookingSuccess ||
          // current is ResidentCancelBookingSuccess ||
          current is ResidentGetBookingLoading,
      builder: (context, state) {
        if (state is ResidentGetBookingLoading ||
            state is ResidentBookingInitial) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        } else {
          return cubit.allBookings.isEmpty
              ? EmptyStateWidget(
                  title: 'noBookings'.tr(context),
                  message: 'noBookingsMsg'.tr(context),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  itemCount: cubit.allBookings.length,
                  itemBuilder: (_, index) => ResidentBookItem(
                    model: cubit.allBookings[index],
                    index: index,
                  ),
                );
        }
      },
    );
  }
}
