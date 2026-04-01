import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/custom_err_get_data.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/manager/cubit/resident_booking_cubit.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/widgets/resident_book_item.dart';

class ResidentAllBookingsList extends StatelessWidget {
  const ResidentAllBookingsList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResidentBookingCubit>();
    return BlocBuilder<ResidentBookingCubit, ResidentBookingState>(
      builder: (context, state) {
        if (state is ResidentGetBookingFailure) {
          return Center(child: CustomErrGetData());
        } else if (state is ResidentGetBookingLoading) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        } else {
          return cubit.allBookings.isEmpty
              ? Center(
                  child: Text(
                    "noBookings".tr(context),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
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
