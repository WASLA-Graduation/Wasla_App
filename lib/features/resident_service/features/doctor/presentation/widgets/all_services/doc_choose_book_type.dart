import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/all_services/choose_many_images_patient.dart';

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
            Text("examination".tr(context), style: Theme.of(context).textTheme.labelMedium),
            Radio(
              value: "Examination",
              groupValue: cubit.doctorBookingTypeGroupValue,
              onChanged: (value) {
                cubit.gruoupValueIndex = 1;
                cubit.images = [];
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
              "consultation".tr(context),
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
        const SizedBox(height: 10),
        Visibility(
          visible: cubit.doctorBookingTypeGroupValue != "Examination",
          child: ChoosePatientManyImageWidget(),
        ),
      ],
    );
  }
}
