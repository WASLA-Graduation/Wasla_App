import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/widgets/choose_many_files_widget.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/technicant/technicant_speciallity_widget.dart';

class TechnicantInfoSelectSpecialization extends StatelessWidget {
  const TechnicantInfoSelectSpecialization({super.key, required this.isTablet});
  final bool isTablet;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
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
                    TechnicantSpecialityWidget(),
                  ],
                ),
              ),
              BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (prev, current) =>
                    current is AuthUpdateTechnicantDocuments,
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
                          files: cubit.driverFiles,
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
              TechnicantSpecialityWidget(),
              BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (prev, current) =>
                    current is AuthUpdateTechnicantDocuments,
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
