import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/manager/cubit/doctor_service_mangement_cubit.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/custom_choose_time_widget.dart';

class CustomChooseTimeDocServiceWidget extends StatelessWidget {
  const CustomChooseTimeDocServiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorServiceMangementCubit>();
    return BlocBuilder<
      DoctorServiceMangementCubit,
      DoctorServiceMangementState
    >(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: CustomChooseTimeWidget(
                text: 'From',
                dateChange: (fromTime) {
                  cubit.upadteTimeFrom(time: fromTime);
                },
                selectedTime: cubit.timeFrom,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomChooseTimeWidget(
                text: 'To',
                dateChange: (toTime) {
                  cubit.upadteTimeTo(time: toTime);
                },
                selectedTime: cubit.timeTo,
              ),
            ),
          ],
        );
      },
    );
  }
}
