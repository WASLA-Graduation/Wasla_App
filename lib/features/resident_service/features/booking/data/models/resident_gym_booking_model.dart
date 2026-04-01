import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/enums/booking_status.dart';
import 'package:wasla/core/functions/format_date_from_string.dart';
import 'package:wasla/features/gym/features/dashboard/data/models/gym_booking_model.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/general_resident_bookings_model.dart';

class GymResidentBookingModel extends GeneralResidentBookingsModel {
  final int bookingId;
  final String gymName;
  final String imageUrl;
  final DateTime bookingTime;
  final int durationInMonths;
  final ServiceNameModel serviceName;
  final int bookingStatus;

  static const String baseImageUrl = "PUT_YOUR_BASE_URL/";

  GymResidentBookingModel({
    required this.bookingId,
    required this.gymName,
    required this.imageUrl,
    required this.bookingTime,
    required this.durationInMonths,
    required this.serviceName,
    required this.bookingStatus,
  }) : super(
         baseBookingId: bookingId,
         baseName: gymName,
         baseServiceName: serviceName.english,
         baseStatus: BookingStatus.fromInt(bookingStatus).name,
         baseImage: imageUrl,
         baseDate: formatDateBooking(bookingTime),
         baseDuration: "$durationInMonths months",
       );

  factory GymResidentBookingModel.fromJson(Map<String, dynamic> json) {
    return GymResidentBookingModel(
      bookingId: json[ApiKeys.bookingId] ?? 0,
      gymName: json[ApiKeys.gymName] ?? '',
      imageUrl: json[ApiKeys.imageUrl] == null || json[ApiKeys.imageUrl] == ''
          ? ''
          : ApiEndPoints.gymBaseUrl + json[ApiKeys.imageUrl],
      bookingTime: DateTime.parse(
        json[ApiKeys.bookingTime] ?? DateTime.now().toString(),
      ),
      durationInMonths: json[ApiKeys.durationInMonths] ?? 0,
      serviceName: ServiceNameModel.fromJson(json[ApiKeys.serviceName] ?? {}),
      bookingStatus: json[ApiKeys.bookingStatus] ?? 0,
    );
  }
}
