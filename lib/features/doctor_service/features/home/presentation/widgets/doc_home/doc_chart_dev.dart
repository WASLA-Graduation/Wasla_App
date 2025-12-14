import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/auth/data/models/drop_down_menu_item.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_drop_down_menu.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/manager/cubit/doctor_home_cubit.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/widgets/doc_home/custom_doctor_chart.dart';

class CustomDoctorDashboardChartDev extends StatelessWidget {
  const CustomDoctorDashboardChartDev({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorHomeCubit>();

    return BlocBuilder<DoctorHomeCubit, DoctorHomeState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: AppColors.primaryColor, width: 0.5),
          ),

          child: Column(
            spacing: 13,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'monthlyRevenue'.tr(context),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: CustomDropDownMenu(
                      initialSelection: cubit.initalSelectedYear,
                      items:
                          cubit.doctorChartModel?.years
                              .map(
                                (year) => DropDownItem(
                                  label: year.year.toString(),
                                  value: year.year.toString(),
                                ),
                              )
                              .toList() ??
                          [
                            DropDownItem(
                              label: DateTime.now().year.toString(),
                              value: DateTime.now().year.toString(),
                            ),
                          ],
                      onSelecte: (year) {
                        if (cubit.doctorChartModel != null &&
                            cubit.doctorChartModel!.years.isNotEmpty) {
                          cubit.getChartDataByYear(year: int.parse(year ?? ''));
                        }
                      },
                    ),
                  ),
                ],
              ),
              CustomDoctorChart(yearDataModel: cubit.yearDataModel),
            ],
          ),
        );
      },
    );
  }
}
