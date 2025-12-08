import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/auth/data/models/drop_down_menu_item.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_drop_down_menu.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/manager/cubit/doctor_home_cubit.dart';

class BookingListHeader extends StatelessWidget {
  const BookingListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorHomeCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          "bookingList".tr(context),
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: 20),
        CustomDropDownMenu(
          hint: 'bookingStatus'.tr(context),
          initialSelection: cubit.bookingStatus.toString(),
          items: [
            DropDownItem(label: 'upComing'.tr(context), value: 1.toString()),
            DropDownItem(label: 'completed'.tr(context), value: 2.toString()),
            DropDownItem(label: 'cancelled'.tr(context), value: 3.toString()),
          ],
          onSelecte: (value) async {
            cubit.bookingStatus = int.parse(value ?? '1');
            await cubit.getDoctorBookings(status: int.parse(value ?? '1'));
          },
        ),
      ],
    );
  }
}
