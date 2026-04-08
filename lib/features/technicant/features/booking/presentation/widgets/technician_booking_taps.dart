import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/technician_booking_status.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/widgets/custom_resident_booking_taps.dart';
import 'package:wasla/features/technicant/features/booking/presentation/manager/cubit/technician_booking_cubit.dart';

class TechnicianBookingsTaps extends StatelessWidget {
  const TechnicianBookingsTaps({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TechnicianBookingCubit, TechnicianBookingState>(
      buildWhen: (previous, current) =>
          current is TechincainBookingUpdateCurrentTapState,
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(TechnicianBookingStatus.values.length, (
              index,
            ) {
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: InkWell(
                  onTap: () {
                    context.read<TechnicianBookingCubit>().updateCurrentTap(
                      index: index,
                    );
                  },
                  child: CustomTapWidget(
                    title: TechnicianBookingStatus.getTitle(
                      index: index,
                    ).tr(context),
                    isSelected:
                        context.read<TechnicianBookingCubit>().currentTap ==
                        index,
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
