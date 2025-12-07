import 'package:wasla/core/database/api/api_keys.dart';

class DoctorChartModel {
  final int numOfPatients;
  final int numOfBookings;
  final int numOfCompletedBookings;
  final double totalAmount;
  final List<dynamic> years;

  DoctorChartModel({
    required this.numOfPatients,
    required this.numOfBookings,
    required this.numOfCompletedBookings,
    required this.totalAmount,
    required this.years,
  });

  factory DoctorChartModel.fromJson(Map<String, dynamic> json) {
    return DoctorChartModel(
      numOfPatients: json[ApiKeys.numOfPatients] ?? 0,
      numOfBookings: json[ApiKeys.numOfBookings] ?? 0,
      numOfCompletedBookings: json[ApiKeys.numOfCompletedBookings] ?? 0,
      totalAmount: json[ApiKeys.totalAmount] ?? 0,
      years: json[ApiKeys.years] ?? [],
    );
  }
}
