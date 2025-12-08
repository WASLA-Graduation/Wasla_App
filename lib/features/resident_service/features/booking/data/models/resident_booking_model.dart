import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';

class ResidentBookingModel {
  final int id;
  final String start;
  final String end;
  final int day;
  final String date;
  final int status;
  final String serviceProviderName;
  final String serviceProviderProfilePhoto;
  final String serviceName;
  final int price;

  ResidentBookingModel({
    required this.id,
    required this.start,
    required this.end,
    required this.day,
    required this.date,
    required this.status,
    required this.serviceProviderName,
    required this.serviceProviderProfilePhoto,
    required this.serviceName,
    required this.price,
  });

  factory ResidentBookingModel.fromJson(Map<String, dynamic> json) {
    return ResidentBookingModel(
      id: json[ApiKeys.id] ?? 0,
      start: json[ApiKeys.start] ?? "",
      end: json[ApiKeys.end] ?? "",
      day: json[ApiKeys.day] ?? 0,
      date: json[ApiKeys.date] ?? "",
      status: json[ApiKeys.status] ?? 0,
      serviceProviderName: json[ApiKeys.serviceProviderName] ?? "",
      serviceProviderProfilePhoto:
          ApiEndPoints.imageBaseUrl + json[ApiKeys.serviceProviderProfilePhoto],
      serviceName: json[ApiKeys.serviceName] ?? "",
      price: json[ApiKeys.price] ?? 0,
    );
  }
}
