import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/dashbord%20and%20charts/custom_general_chart.dart';
import 'package:wasla/features/auth/data/models/drop_down_menu_item.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_drop_down_menu.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_chart_model.dart';

class DashboardChartCard extends StatelessWidget {
  const DashboardChartCard({
    super.key,
    required this.title,
    required this.years,
    required this.selectedYear,
    required this.onYearChanged,
    required this.yearDataModel,
  });

  final String title;
  final List<int> years;
  final String selectedYear;
  final Function(String?) onYearChanged;
  final YearDataModel? yearDataModel;

  @override
  Widget build(BuildContext context) {
    final points = yearDataModel?.toChartPoints() ?? [];

    return Container(
      padding: const EdgeInsets.all(15),
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
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: CustomDropDownMenu(
                  initialSelection: selectedYear,
                  items: years
                      .map(
                        (year) => DropDownItem(
                          label: year.toString(),
                          value: year.toString(),
                        ),
                      )
                      .toList(),
                  onSelecte: onYearChanged,
                ),
              ),
            ],
          ),
          CustomAreaChart(points: points),
        ],
      ),
    );
  }
}
