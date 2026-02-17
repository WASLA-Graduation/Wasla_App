import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/enums/booking_status.dart';

class GymBookingModel {
  final int bookingId;
  final String name;
  final String imageUrl;
  final DateTime bookingTime;
  final int durationInMonths;
  final ServiceNameModel serviceName;
  final double price;
  final BookingStatus bookingStatus;

  GymBookingModel({
    required this.bookingId,
    required this.name,
    required this.imageUrl,
    required this.bookingTime,
    required this.durationInMonths,
    required this.serviceName,
    required this.price,
    required this.bookingStatus,
  });

  factory GymBookingModel.fromJson(Map<String, dynamic> json) {
    return GymBookingModel(
      bookingId: json[ApiKeys.bookingId] ?? 0,
      name: json[ApiKeys.name] ?? '',
      imageUrl: json[ApiKeys.imageUrl] ?? '',
      bookingTime: DateTime.parse(
        json[ApiKeys.bookingTime] ?? DateTime.now().toIso8601String(),
      ),
      durationInMonths: json[ApiKeys.durationInMonths] ?? 0,
      serviceName: ServiceNameModel.fromJson(json[ApiKeys.serviceName] ?? {}),
      price: (json[ApiKeys.price] ?? 0).toDouble(),
      bookingStatus: BookingStatus.fromInt(json[ApiKeys.bookingStatus] ?? 0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.bookingId: bookingId,
      ApiKeys.name: name,
      ApiKeys.imageUrl: imageUrl,
      ApiKeys.bookingTime: bookingTime.toIso8601String(),
      ApiKeys.durationInMonths: durationInMonths,
      ApiKeys.serviceName: serviceName.toJson(),
      ApiKeys.price: price,
      ApiKeys.bookingStatus: bookingStatus.toInt(),
    };
  }
}

class ServiceNameModel {
  final String english;
  final String arabic;

  ServiceNameModel({required this.english, required this.arabic});

  factory ServiceNameModel.fromJson(Map<String, dynamic> json) {
    return ServiceNameModel(
      english: json[ApiKeys.nameEnglish] ?? '',
      arabic: json[ApiKeys.nameArabic] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {ApiKeys.nameEnglish: english, ApiKeys.nameArabic: arabic};
  }
}
