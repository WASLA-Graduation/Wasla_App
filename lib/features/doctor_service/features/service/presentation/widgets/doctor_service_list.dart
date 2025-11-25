import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/manager/cubit/doctor_service_mangement_cubit.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/doc_service_item.dart';

class DoctorServiceList extends StatelessWidget {
  const DoctorServiceList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorServiceMangementCubit>();
    return BlocBuilder<
      DoctorServiceMangementCubit,
      DoctorServiceMangementState
    >(
      builder: (context, state) {
        if (state is DoctorServiceMangementGetServiceFailure) {
          return const Center(child: Text("error"));
        } else if (state is DoctorServiceMangementGetServiceLoading ||
            state is DoctorServiceMangementDelateServiceLoading) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        } else {
          return cubit.sevices.isEmpty
              ? Center(
                  child: Text(
                    "No Services",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: cubit.sevices.length,
                  itemBuilder: (context, index) =>
                      DocServiceItem(doctorServiceModel: cubit.sevices[index]),
                );
        }
      },
    );
  }
}
