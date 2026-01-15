import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/custom_err_get_data.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/resident_booking_model.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/manager/cubit/resident_booking_cubit.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/widgets/resident_book_item.dart';

// ignore: must_be_immutable
class ResidentBookingList extends StatelessWidget {
  ResidentBookingList({super.key});
  List<ResidentBookingModel> bookigns = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResidentBookingCubit, ResidentBookingState>(
      builder: (context, state) {
        if (state is ResidentGetBookingFailure) {
          return CustomErrGetData();
        } else if (state is ResidentGetBookingLoading) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        } else {
          if (state is ResidentGetBookingSuccess) {
            bookigns = state.bookings;
          }

          return bookigns.isEmpty
              ? Center(
                  child: Text(
                    "noBookings".tr(context),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                )
              : ListView.builder(
                padding: const EdgeInsets.only(top: 20),
                  itemCount: bookigns.length,
                  itemBuilder: (_, index) =>
                      ResidentBookItem(model: bookigns[index], index: index),
                );
        }
      },
    );
  }
}
