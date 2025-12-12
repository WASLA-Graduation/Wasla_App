import 'package:wasla/core/database/api/api_keys.dart';

class DoctorChartModel {
  final int numOfPatients;
  final int numOfBookings;
  final int numOfCompletedBookings;
  final double totalAmount;
  final List<YearDataModel> years;

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
      totalAmount: (json[ApiKeys.totalAmount] ?? 0).toDouble(),
      years: (json[ApiKeys.years] as List<dynamic>?)
              ?.map((e) => YearDataModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class YearDataModel {
  final int year;
  final List<MonthDataModel> months;

  YearDataModel({
    required this.year,
    required this.months,
  });

  factory YearDataModel.fromJson(Map<String, dynamic> json) {
    return YearDataModel(
      year: json[ApiKeys.year] ?? 0,
      months: (json[ApiKeys.months] as List<dynamic>?)
              ?.map((e) => MonthDataModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class MonthDataModel {
  final int month;
  final double amount;

  MonthDataModel({
    required this.month,
    required this.amount,
  });

  factory MonthDataModel.fromJson(Map<String, dynamic> json) {
    return MonthDataModel(
      month: json[ApiKeys.month] ?? 0,
      amount: (json[ApiKeys.amount] ?? 0).toDouble(),
    );
  }
}
