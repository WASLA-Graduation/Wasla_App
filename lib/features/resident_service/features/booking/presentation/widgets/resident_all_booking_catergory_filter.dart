import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/booking_filter.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/manager/cubit/resident_booking_cubit.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/widgets/custom_resident_booking_taps.dart';

class ResidentAllBookingsCategoryFilter extends StatelessWidget {
  const ResidentAllBookingsCategoryFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResidentBookingCubit>();
    return SizedBox(
      height: 40,
      child: BlocBuilder<ResidentBookingCubit, ResidentBookingState>(
        builder: (context, state) {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: 2,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(left: 25),
              child: CustomTapWidget(
                isSelected: cubit.bookingFilter == BookingFilter.values[index],
                title: BookingFilter.titleFromIndex(index).tr(context),
                onTap: () {
                  cubit.updateBookingTaps(
                    bookingFilter: BookingFilter.values[index],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
