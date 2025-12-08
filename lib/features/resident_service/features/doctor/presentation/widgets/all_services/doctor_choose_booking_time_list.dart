import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/format_time_with_intl.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/doctor_service/features/service/data/models/doctor_service_model.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';

class ChooseBookingTimeList extends StatelessWidget {
  const ChooseBookingTimeList({super.key, required this.doctorServiceModel});
  final DoctorServiceModel doctorServiceModel;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorCubit>();
    return cubit.dayListTimeSlots.isEmpty
        ? SliverToBoxAdapter(
            child: Text(
              "allTimesBooked".tr(context),
              style: TextStyle(color: AppColors.primaryColor),
            ),
          )
        : SliverGrid.builder(
            itemCount: cubit.dayListTimeSlots.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 14,
              mainAxisExtent: 40,
            ),
            itemBuilder: (_, index) => InkWell(
              onTap: () {
                cubit.changeTimeCurrentIndex(
                  index,
                  serviceDay:
                      doctorServiceModel.serviceDays[cubit.dayCurrentIndex],
                );
              },
              child: _buildTimeContainer(
                context,
                cubit.dayListTimeSlots[index],
                cubit.timeCurrentIndex == index,
              ),
            ),
          );
  }

  Container _buildTimeContainer(
    BuildContext context,
    String time,
    bool isSelected,
  ) {
    return Container(
      decoration: ShapeDecoration(
        shape: const StadiumBorder(
          side: BorderSide(width: 2, color: AppColors.primaryColor),
        ),
        color: isSelected ? AppColors.primaryColor : Colors.transparent,
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            convertBackendTimeToAmPm(time),

            // '${convertBackendTimeToAmPm(splitTime(time)[0])}:${convertBackendTimeToAmPm(splitTime(time)[1])}',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: isSelected ? AppColors.whiteColor : AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  List<String> splitTime(time) => time.split('-');
}
