import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';

class DoctorBooking {
  final int bookingId;
  final String serviceName;
  final String userName;
  final String userImage;
  final String date;
  final String start;
  final String end;
  final int day;
  final int bookingType;
  final String phone;
  final int price;
  final List<String> bookingImages;

  DoctorBooking({
    required this.bookingId,
    required this.serviceName,
    required this.userName,
    required this.userImage,
    required this.date,
    required this.start,
    required this.end,
    required this.day,
    required this.bookingType,
    required this.phone,
    required this.price,
    required this.bookingImages,
  });

  factory DoctorBooking.fromJson(Map<String, dynamic> json) {
    return DoctorBooking(
      bookingId: json[ApiKeys.bookingId] ?? 0,
      serviceName: json[ApiKeys.serviceName] ?? "",
      userName: json[ApiKeys.userName] ?? "",
      userImage: json[ApiKeys.userImage] ?? "",
      date: json[ApiKeys.date] ?? "",
      start: json[ApiKeys.start] ?? "",
      end: json[ApiKeys.end] ?? "",
      day: json[ApiKeys.day] ?? 0,
      bookingType: json[ApiKeys.bookingType] ?? 0,
      phone: json[ApiKeys.phoneSmall] ?? "",
      price: json[ApiKeys.price] ?? 0,
      bookingImages:
          (json[ApiKeys.bookingImages] as List<String>?)
              ?.map((e) => ApiEndPoints.imageBaseUrl + e)
              .toList() ??
          [],
    );
  }
}
