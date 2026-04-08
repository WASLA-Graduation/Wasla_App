import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/widgets/choose_many_files_widget.dart';
import 'package:wasla/features/auth/presentation/widgets/technicant/technicant_speciallity_widget.dart';
import 'package:wasla/features/profile/presentation/manager/cubit/profile_cubit.dart';

class TechnicianEditSpecializationSelect extends StatelessWidget {
  const TechnicianEditSpecializationSelect({
    super.key,
    required this.isTablet,
    required this.selectedSpecialization,
  });

  final bool isTablet;
  final int selectedSpecialization;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return isTablet
        ? Row(
            spacing: 20.h,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 11,
                  children: [
                    Text(
                      "specialty".tr(context),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    BlocBuilder<ProfileCubit, ProfileState>(
                      buildWhen: (previous, current) =>
                          current is ProfileUpdateTechnicantSpecialization,
                      builder: (context, state) {
                        final cubit = context.read<ProfileCubit>();
                        return TechnicantSpecialityWidget(
                          initialValue: (selectedSpecialization - 1).toString(),
                          onSelect: (specialty) {
                            cubit.updateTechnicianSpeciality(
                              specialityId: int.parse(specialty),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              BlocBuilder<ProfileCubit, ProfileState>(
                buildWhen: (prev, current) =>
                    current is ProfileUpdateTechnicantDocuments,
                builder: (context, state) {
                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 11,
                      children: [
                        Text(
                          "documents".tr(context),
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        ChooseManyFilesWidget(
                          files: cubit.technicantDocuments,
                          hintText: "documents".tr(context),
                          onFilesSelected: (files) {
                            cubit.updateTechnicantDocuments(files);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          )
        : Column(
            spacing: 20.h,
            children: [
              BlocBuilder<ProfileCubit, ProfileState>(
                buildWhen: (previous, current) =>
                    current is ProfileUpdateTechnicantSpecialization,
                builder: (context, state) {
                  final cubit = context.read<ProfileCubit>();
                  return TechnicantSpecialityWidget(
                    initialValue: (selectedSpecialization - 1).toString(),
                    onSelect: (specialty) {
                      cubit.updateTechnicianSpeciality(
                        specialityId: int.parse(specialty),
                      );
                    },
                  );
                },
              ),
              BlocBuilder<ProfileCubit, ProfileState>(
                buildWhen: (prev, current) =>
                    current is ProfileUpdateTechnicantDocuments,
                builder: (context, state) {
                  return ChooseManyFilesWidget(
                    files: cubit.technicantDocuments,
                    hintText: "documents".tr(context),
                    onFilesSelected: (files) {
                      cubit.updateTechnicantDocuments(files);
                    },
                  );
                },
              ),
            ],
          );
  }
}
