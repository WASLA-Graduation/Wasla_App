import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/widgets/custom_decorated_container.dart';
import 'package:wasla/features/auth/data/models/drop_down_menu_item.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/manager/cubit/doctor_home_cubit.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/widgets/booking/booking_list_header.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/widgets/booking/doc_booking_data_card.dart';

class DoctorBookingList extends StatelessWidget {
  const DoctorBookingList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorHomeCubit>();
    return CustomDecoratedContainer(
      child: Column(
        spacing: 20,
        children: [
          CustomListHeader(
            title: "bookingList".tr(context),
            hint: "bookingStatus".tr(context),
            initialValue: cubit.bookingStatus.toString(),
            items: [
              DropDownItem(label: "upComing".tr(context), value: "1"),
              DropDownItem(label: "completed".tr(context), value: "2"),
              DropDownItem(label: "cancelled".tr(context), value: "3"),
            ],
            onChanged: (value) async {
              final status = int.parse(value ?? "1");
              cubit.bookingStatus = status;
              await cubit.getDoctorBookings(status: status);
            },
          ),
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
