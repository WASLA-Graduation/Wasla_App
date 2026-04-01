import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/enums/booking_status.dart';
import 'package:wasla/core/functions/format_date_from_string.dart';
import 'package:wasla/core/functions/format_time_with_intl.dart';
import 'package:wasla/core/functions/localizedDays.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/general_resident_bookings_model.dart';

class DoctorResidentBookingModel extends GeneralResidentBookingsModel {
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

  DoctorResidentBookingModel({
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
  }) : super(
         baseBookingId: id,
         baseName: serviceProviderName,
         baseServiceName: serviceName,
         baseStatus: DoctorBookingStatus.values[status-1].name,
         baseImage: serviceProviderProfilePhoto,
         baseDate: formatStringDate(date) + localizedDays(index: day),
         baseDuration:
             "${convertBackendTimeToAmPm(start)} : ${convertBackendTimeToAmPm(end)}",
       );

  factory DoctorResidentBookingModel.fromJson(Map<String, dynamic> json) {
    return DoctorResidentBookingModel(
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
