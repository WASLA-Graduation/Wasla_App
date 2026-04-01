import 'package:wasla/features/doctor_service/features/home/data/models/doctor_chart_model.dart';

class DriverStatisticsModel {
  final int numberOfRides;
  final int numberOfDeliveredResident;
  final double totalAmount;
  final List<YearDataModel> years;

  DriverStatisticsModel({
    required this.numberOfRides,
    required this.numberOfDeliveredResident,
    required this.totalAmount,
    required this.years,
  });

  factory DriverStatisticsModel.fromJson(Map<String, dynamic> json) {
    return DriverStatisticsModel(
      numberOfRides: json['numberOfRides'],
      numberOfDeliveredResident: json['numberOfDeliveredResident'],
      totalAmount: (json['totalAmount'] as num).toDouble(),
      years: (json['years'] as List)
          .map((e) => YearDataModel.fromJson(e))
          .toList(),
    );
  }
  List<YearDataModel> get sortedYearsDesc {
    List<YearDataModel> sortedYears = List.from(years);
    sortedYears.sort((a, b) => b.year.compareTo(a.year));
    return sortedYears;
  }
}
