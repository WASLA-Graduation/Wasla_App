import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/helpers/loadings/speciality_loading_list.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_speciality_item.dart';

class CustomDoctorSpecialityList extends StatelessWidget {
  const CustomDoctorSpecialityList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorCubit>();
    return BlocConsumer<DoctorCubit, DoctorState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
          height: 40,
          child: state is DoctorGetSpecialityListLoading
              ?const SpecialityLoadingList()
              : ListView.builder(
                  itemCount: cubit.specialityList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => DoctorSpecialityitem(
                    doctorSpecializationaModel: cubit.specialityList[index],
                  ),
                ),
        );
      },
    );
  }
}
