import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/localize_month.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_chart_model.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_dashboard_chart_data_model.dart';

// class CustomDoctorChart extends StatelessWidget {
//   const CustomDoctorChart({super.key, this.yearDataModel});
//   final YearDataModel? yearDataModel;

//   @override
//   Widget build(BuildContext context) {
//     final chartData = yearDataModel?.toChartData() ??
//         List.generate(
//           12,
//           (index) => DoctorDashboardChartDataModel(
//             (index + 1).toString(),
//             0,
//           ),
//         );

//     return SfCartesianChart(
//       zoomPanBehavior: ZoomPanBehavior(
//         enablePanning: true,
//         enablePinching: false,
//         zoomMode: ZoomMode.x,
//       ),

//       primaryXAxis: CategoryAxis(
//         majorGridLines: const MajorGridLines(width: 0),
//         initialVisibleMinimum: 0,
//         initialVisibleMaximum: 5,
//       ),

//       primaryYAxis: NumericAxis(
//         majorGridLines: const MajorGridLines(width: 1),
//       ),

//       series: <SplineAreaSeries<DoctorDashboardChartDataModel, String>>[
//         SplineAreaSeries<DoctorDashboardChartDataModel, String>(
//           dataSource: chartData,

//           xValueMapper: (data, _) =>
//               getMonth(int.parse(data.month)).tr(context),

//           yValueMapper: (data, _) => data.amount,

//           color: AppColors.primaryColor.withOpacity(0.25),
//           borderColor: AppColors.primaryColor,
//           borderWidth: 3,
//           splineType: SplineType.clamped,
//         ),
//       ],
//     );
//   }
// }


// extension YearDataChartExtension on YearDataModel {
//   List<DoctorDashboardChartDataModel> toChartData() {
//     final Map<int, double> monthAmountMap = {
//       for (var m in months) m.month: m.amount,
//     };

//     return List.generate(12, (index) {
//       final monthNumber = index + 1;
//       return DoctorDashboardChartDataModel(
//         monthNumber.toString(),
//         monthAmountMap[monthNumber] ?? 0, 
//       );
//     });
//   }
// }








