import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/helpers/loadings/speciality_loading_list.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_speciality_item.dart';
import 'package:wasla/features/resident_service/features/technicain/data/models/technician_specialization_model.dart';
import 'package:wasla/features/resident_service/features/technicain/presentation/manager/cubit/resident_technician_cubit.dart';

class ResidentTechSpacializationList extends StatefulWidget {
  const ResidentTechSpacializationList({super.key});

  @override
  State<ResidentTechSpacializationList> createState() =>
      _ResidentTechSpacializationListState();
}

class _ResidentTechSpacializationListState
    extends State<ResidentTechSpacializationList> {
  List<TechnicianSpecializationModel> specialiations = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResidentTechnicianCubit, ResidentTechnicianState>(
      buildWhen: (previous, current) =>
          current is ResidentTechnicianGetSpecializationsLoading ||
          current is ResidentTechnicianGetSpecializationsLoaded ||
          current is ResidentTechnicianSelectSpecialization,
      builder: (context, state) {
        if (state is ResidentTechnicianGetSpecializationsLoading ||
            state is ResidentTechnicianInitial) {
          return const SpecialityLoadingList();
        }
        if (state is ResidentTechnicianGetSpecializationsLoaded) {
          specialiations = state.specialiations;
        }
        if (specialiations.isEmpty) {
          return const SpecialityLoadingList();
        }
        return SizedBox(
          height: 40,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 7),
            itemCount: specialiations.length,
            itemBuilder: (context, index) {
              return ResidentTechSpacializationListItem(
                speciality: specialiations[index],
              );
            },
          ),
        );
      },
    );
  }
}

class ResidentTechSpacializationListItem extends StatelessWidget {
  const ResidentTechSpacializationListItem({
    super.key,
    required this.speciality,
  });
  final TechnicianSpecializationModel speciality;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResidentTechnicianCubit>();
    return InkWell(
      onTap: () {
        cubit.chooseSpecialization(index: speciality.id);
      },
      child: CategoryFilteritema(
        title: speciality.name,
        isSelected: cubit.currentSpeciality == speciality.id,
      ),
    );
  }
}
