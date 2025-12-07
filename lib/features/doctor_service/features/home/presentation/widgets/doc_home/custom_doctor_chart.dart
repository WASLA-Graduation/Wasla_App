import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/dashboard_data_model.dart';

class CustomDoctorChart extends StatelessWidget {
  const CustomDoctorChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: 'monthlyRevenue'.tr(context)),

      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
      ),

      primaryYAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0.5),
      ),

      series: <SplineAreaSeries<SalesData, String>>[
        SplineAreaSeries<SalesData, String>(
          dataSource: [
            SalesData('Sat', 35),
            SalesData('Sun', 28),
            SalesData('Mon', 34),
            SalesData('Wed', 40),
            SalesData('Thu', 32),
            SalesData('Fri', 35),
          ],

          xValueMapper: (SalesData sales, _) => sales.day,
          yValueMapper: (SalesData sales, _) => sales.sales,

          color: AppColors.primaryColor.withOpacity(0.25),

          borderColor: AppColors.primaryColor,
          borderWidth: 3,

          splineType: SplineType.clamped,

          dataLabelSettings: DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}
