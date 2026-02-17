import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_chart_model.dart';

class GymStatisticsModel {
  final int numberOfBookings;
  final int numberOfTrainees;
  final double totalAmount;
  final List<YearDataModel> years;

  GymStatisticsModel({
    required this.numberOfBookings,
    required this.numberOfTrainees,
    required this.totalAmount,
    required this.years,
  });

  factory GymStatisticsModel.fromJson(Map<String, dynamic> json) {
    final data = json[ApiKeys.data];

    return GymStatisticsModel(
      numberOfBookings: data[ApiKeys.numberOfBookings] ?? 0,
      numberOfTrainees: data[ApiKeys.numberOfTrainees] ?? 0,
      totalAmount: (data[ApiKeys.totalAmount] ?? 0).toDouble(),
      years: (data[ApiKeys.years] as List? ?? [])
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

