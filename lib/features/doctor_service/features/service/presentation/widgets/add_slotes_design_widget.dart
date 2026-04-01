import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/manager/cubit/doctor_service_mangement_cubit.dart';

class AddSlotesDesignWidget extends StatelessWidget {
  const AddSlotesDesignWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorServiceMangementCubit>();
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: AppColors.gray, width: 0.3),
      ),
      child: Center(
        child: InkWell(
          onTap: () {
            context.read<DoctorServiceMangementCubit>().addTimeSlot();
          },
          child: Row(
            children: [
              BlocBuilder<
                DoctorServiceMangementCubit,
                DoctorServiceMangementState
              >(
                builder: (context, state) {
                  return Text(
                    cubit.timeSlotsList.isEmpty
                        ? "addTime".tr(context)
                        : "addMoreSlots".tr(context),
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                },
              ),
              const Spacer(),
              Image.asset(Assets.assetsImagesAdd, width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
