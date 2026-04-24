import 'package:wasla/features/doctor_service/features/home/data/models/doctor_chart_model.dart';

class ResturantChartModel {
  final int numberOfReservations;
  final int numOfOrders;
  final int numOfCompletedOrders;
  final double totalAmount;
  final List<YearDataModel> years;

  ResturantChartModel({
    required this.numberOfReservations,
    required this.numOfOrders,
    required this.numOfCompletedOrders,
    required this.totalAmount,
    required this.years,
  });

  factory ResturantChartModel.fromJson(Map<String, dynamic> json) {
    return ResturantChartModel(
      numberOfReservations: json['numberOfReservations'] ?? 0,
      numOfOrders: json['numOfOrders'] ?? 0,
      numOfCompletedOrders: json['numOfCompletedOrders'] ?? 0,
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
      years: (json['years'] as List? ?? [])
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
