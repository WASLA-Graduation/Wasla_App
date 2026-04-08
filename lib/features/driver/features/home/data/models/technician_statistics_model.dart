import 'package:wasla/features/doctor_service/features/home/data/models/doctor_chart_model.dart';

class TechnicianStatisticsModel {
  final int completedBookings;
  final int numberOfResidents;
  final int totalAmount;
  final List<YearDataModel> years;

  TechnicianStatisticsModel({
    required this.completedBookings,
    required this.numberOfResidents,
    required this.totalAmount,
    required this.years,
  });

  factory TechnicianStatisticsModel.fromJson(Map<String, dynamic> json) {
    return TechnicianStatisticsModel(
      completedBookings: json['completedBookings'],
      numberOfResidents: json['numberOfResidents'],
      totalAmount: json['totalAmount'],
      years: List<YearDataModel>.from(
        json['years'].map((e) => YearDataModel.fromJson(e)),
      ),
    );
  }

  List<YearDataModel> get sortedYearsDesc {
    List<YearDataModel> sortedYears = List.from(years);
    sortedYears.sort((a, b) => b.year.compareTo(a.year));
    return sortedYears;
  }
}
