import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/functions/format_time_with_intl.dart';
import 'package:wasla/features/doctor_service/features/service/data/models/doctor_service_model.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/manager/cubit/doctor_service_mangement_cubit.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/custom_choose_time_doc_service_widget.dart';

class AddSlotList extends StatefulWidget {
  const AddSlotList({super.key, this.timeSlots});
  final List<TimeSlotModel>? timeSlots;
  @override
  State<AddSlotList> createState() => _AddSlotListState();
}

class _AddSlotListState extends State<AddSlotList> {
  @override
  void initState() {
    fillTimeSlotList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorServiceMangementCubit>();
    return BlocBuilder<
      DoctorServiceMangementCubit,
      DoctorServiceMangementState
    >(
      builder: (_, state) {
        return ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: cubit.timeSlotsList.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            return CustomChooseTimeDocServiceWidget(
              dateChangeFrom: (timeFrom) {
                cubit.upadeTimeSlot(index: index, time: timeFrom, isFrom: true);
              },
              dateChangeTo: (timeTo) {
                cubit.upadeTimeSlot(index: index, time: timeTo, isFrom: false);
              },
              onDelete: () => cubit.removeTimeSlot(index: index),
              to: cubit.timeSlotsList[index]['from']!,
              from: cubit.timeSlotsList[index]['to']!,
            );
          },
        );
      },
    );
  }

  void fillTimeSlotList() {
    final cubit = context.read<DoctorServiceMangementCubit>();
    if (widget.timeSlots != null) {
      for (var element in widget.timeSlots!) {
        final TimeOfDay from = convertStringToTimeOfDay(element.start);
        final TimeOfDay to = convertStringToTimeOfDay(element.end);
        cubit.timeSlotsList.add({'from': from, 'to': to});
      }
    }
  }
}
