import 'package:wasla/core/functions/format_date_from_string.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/general_resident_bookings_model.dart';

class DriverRideBookings extends GeneralResidentBookingsModel {
  final int rideId;
  final String residentName;
  final String residentPhone;
  final String residentImage;
  final String pickUpPlace;
  final String dropOffPlace;
  final DateTime rideDate;
  final double price;
  final double distance;
  final String status;

  DriverRideBookings({
    required this.rideId,
    required this.residentName,
    required this.residentPhone,
    required this.residentImage,
    required this.pickUpPlace,
    required this.dropOffPlace,
    required this.rideDate,
    required this.price,
    required this.distance,
    required this.status,
  }) : super(
         baseBookingId: rideId,
         baseName: residentName,
         baseServiceName: formatDateBooking(rideDate),
         baseStatus: 'completed',
         baseImage: residentImage,
         baseDate: '$pickUpPlace -> $dropOffPlace ',
         baseDuration:
             '${price.toStringAsFixed(0)} EGP | ${distance.toStringAsFixed(0)} KM | $residentPhone',
       );

  factory DriverRideBookings.fromJson(Map<String, dynamic> json) {
    return DriverRideBookings(
      rideId: json['rideId'],
      residentName: json['residentName'],
      residentPhone: json['residentPhone'],
      residentImage: json['residentImage'],
      pickUpPlace: json['pickUpPlace'],
      dropOffPlace: json['dropOffPlace'],
      rideDate: DateTime.parse(json['rideDate']),
      price: (json['price'] as num).toDouble(),
      distance: (json['distance'] as num).toDouble(),
      status: json['status'],
    );
  }
}
