import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/localizedDays.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/doctor_service/features/service/data/models/doctor_service_model.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';

class ChooseDoctorBookingDay extends StatelessWidget {
  const ChooseDoctorBookingDay({super.key, required this.serviceDayList});
  final List<ServiceDayModel> serviceDayList;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15,
      children: [
        Text(
          "selectDay".tr(context),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              serviceDayList.length,
              (index) => InkWell(
                onTap: () {
                  cubit.changeDayCurrentIndexAndUpadatTimeSlote(
                    index,
                    serviceDay: serviceDayList[index],
                  );
                  cubit.timeCurrentIndex = -1;
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 7,
                  ),
                  decoration: _buildContainerDecoration(cubit, index),
                  child: _buildDayWidget(index, context, cubit),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  BoxDecoration _buildContainerDecoration(DoctorCubit cubit, int index) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: cubit.dayCurrentIndex == index
          ? AppColors.primaryColor
          : AppColors.grayDark.withOpacity(0.16),
      border: Border.all(
        color: cubit.dayCurrentIndex == index
            ? AppColors.primaryColor
            : AppColors.gray,
        width: 0.5,
      ),
    );
  }

  Text _buildDayWidget(int index, BuildContext context, DoctorCubit cubit) {
    return Text(
      localizedDays(index: serviceDayList[index].dayOfWeek).tr(context),
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
        fontWeight: FontWeight.w400,
        color: index == cubit.dayCurrentIndex
            ? AppColors.whiteColor
            : AppColors.grayDark,
      ),
    );
  }
}
