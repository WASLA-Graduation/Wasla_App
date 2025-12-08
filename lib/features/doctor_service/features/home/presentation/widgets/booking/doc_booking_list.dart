import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/manager/cubit/doctor_home_cubit.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/widgets/booking/booking_list_header.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/widgets/booking/doc_booking_data_card.dart';

class DoctorBookingList extends StatelessWidget {
  const DoctorBookingList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorHomeCubit>();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: AppColors.primaryColor, width: 0.5),
      ),

      child: Column(
        spacing: 20,
        children: [
          BookingListHeader(),
          cubit.doctorBookings.isEmpty
              ? Center(
                  child: Text(
                    "noBookings".tr(context),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemCount: cubit.doctorBookings.length,
                  itemBuilder: (_, index) => DocBookingDataCard(
                    model: cubit.doctorBookings[index],
                    index: index,
                  ),
                ),
        ],
      ),
    );
  }
}
