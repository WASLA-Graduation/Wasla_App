import 'package:wasla/core/enums/technician_booking_status.dart';

class TechnicainBookingModel {
  final int bookingId;
  final String residentName;
  final String residentPhone;
  final String residentImage;
  final double latitude;
  final double longitude;
  final double price;
  final DateTime bookingDate;
  TechnicianBookingStatus status;

  TechnicainBookingModel({
    required this.bookingId,
    required this.residentName,
    required this.residentPhone,
    required this.residentImage,
    required this.latitude,
    required this.longitude,
    required this.price,
    required this.bookingDate,
    required this.status,
  });

  factory TechnicainBookingModel.fromJson(Map<String, dynamic> json) {
    return TechnicainBookingModel(
      bookingId: json['bookingId'],
      residentName: json['residentName'],
      residentPhone: json['residentPhone'],
      residentImage: json['residentImage'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      bookingDate: DateTime.parse(json['bookingDate']),
      status: TechnicianBookingStatus.values[json['status'] - 1],
    );
  }
}
