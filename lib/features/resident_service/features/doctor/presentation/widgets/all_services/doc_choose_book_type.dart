import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';

class DoctorChooseTypeOfBookig extends StatelessWidget {
  const DoctorChooseTypeOfBookig({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<DoctorCubit>();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Examination", style: Theme.of(context).textTheme.labelMedium),
            Radio(
              value: "Examination",
              groupValue: cubit.doctorBookingTypeGroupValue,
              onChanged: (value) {
                cubit.gruoupValueIndex = 1;
                cubit.updateDoctorGroupValue(value!);
              },
              side: const BorderSide(color: AppColors.primaryColor),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Text(
              "Consultation",
              style: Theme.of(context).textTheme.labelMedium,
            ),

            Radio(
              value: "Consultation",
              groupValue: cubit.doctorBookingTypeGroupValue,
              onChanged: (value) {
                cubit.gruoupValueIndex = 2;
                cubit.updateDoctorGroupValue(value!);
              },
              side: const BorderSide(color: AppColors.primaryColor),
            ),
          ],
        ),
      ],
    );
  }
}
