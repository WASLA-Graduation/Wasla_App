import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/booking_status.dart';
import 'package:wasla/core/widgets/custom_decorated_container.dart';
import 'package:wasla/features/auth/data/models/drop_down_menu_item.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/widgets/booking/booking_list_header.dart';
import 'package:wasla/features/gym/features/dashboard/presentation/manager/cubit/gym_dashboard_cubit.dart';
import 'package:wasla/features/gym/features/dashboard/presentation/widgets/gym_booking_item.dart';

class GymBookingList extends StatelessWidget {
  const GymBookingList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GymDashboardCubit>();
    return CustomDecoratedContainer(
      child: Column(
        spacing: 20,
        children: [
          CustomListHeader(
            title: "bookingList".tr(context),
            hint: "bookingStatus".tr(context),
            initialValue: cubit.gymBookingsStatus.toInt().toString(),
            items: [
              DropDownItem(label: "active".tr(context), value: "0"),
              DropDownItem(label: "completed".tr(context), value: "1"),
              DropDownItem(label: "cancelled".tr(context), value: "2"),
            ],
            onChanged: (value) async {
              final status = int.parse(value ?? "0");
              cubit.whenBookingStatusChanged(
                status: BookingStatus.fromInt(status),
              );
            },
          ),
          cubit.gymBookings.isEmpty
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
                  itemCount: cubit.gymBookings.length,
                  itemBuilder: (_, index) => GymBookingItem(
                    bookingModel: cubit.gymBookings[index],
                    index: index,
                  ),
                ),
        ],
      ),
    );
  }
}
