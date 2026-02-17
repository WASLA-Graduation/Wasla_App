import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/localize_month.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_chart_model.dart';

class CustomAreaChart extends StatelessWidget {
  const CustomAreaChart({
    super.key,
    required this.points,
  });

  final List<ChartPoint> points;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      zoomPanBehavior: ZoomPanBehavior(
        enablePanning: true,
        zoomMode: ZoomMode.x,
      ),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
        initialVisibleMinimum: 0,
        initialVisibleMaximum: 5,
      ),
      primaryYAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 1),
      ),
      series: <SplineAreaSeries<ChartPoint, String>>[
        SplineAreaSeries<ChartPoint, String>(
          dataSource: points,
          xValueMapper: (data, _) =>
              getMonth(data.month).tr(context),
          yValueMapper: (data, _) => data.value,
          color: AppColors.primaryColor.withOpacity(0.25),
          borderColor: AppColors.primaryColor,
          borderWidth: 3,
          splineType: SplineType.clamped,
        ),
      ],
    );
  }
}


extension YearDataChartExtension on YearDataModel {
  List<ChartPoint> toChartPoints() {
    final Map<int, double> monthMap = {
      for (var m in months) m.month: m.amount,
    };

    return List.generate(12, (index) {
      final monthNumber = index + 1;

      return ChartPoint(
        month: monthNumber,
        value: monthMap[monthNumber] ?? 0,
      );
    });
  }
}


class ChartPoint {
  final int month;
  final double value;

  const ChartPoint({
    required this.month,
    required this.value,
  });
}
