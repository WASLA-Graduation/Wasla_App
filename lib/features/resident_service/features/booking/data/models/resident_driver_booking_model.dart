import 'package:wasla/core/functions/format_date_from_string.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/general_resident_bookings_model.dart';

class ResidentDriverBookingModel extends GeneralResidentBookingsModel {
  final int rideId;
  final String driverName;
  final String driverPhoto;
  final String driverPhone;
  final String pickUpPlace;
  final String dropOffPlace;
  final DateTime rideDate;
  final double price;
  final String status;

  ResidentDriverBookingModel({
    required this.rideId,
    required this.driverName,
    required this.driverPhoto,
    required this.driverPhone,
    required this.pickUpPlace,
    required this.dropOffPlace,
    required this.rideDate,
    required this.price,
    required this.status,
  }) : super(
         baseBookingId: rideId,
         baseName: driverName,
         baseServiceName: 'Driver',
         baseStatus: 'completed',
         baseImage: driverPhoto,
         baseDate:
             '$pickUpPlace -> $dropOffPlace ',
         baseDuration: formatDateBooking(rideDate)  ,
       );

  factory ResidentDriverBookingModel.fromJson(Map<String, dynamic> json) {
    return ResidentDriverBookingModel(
      rideId: json['rideId'],
      driverName: json['driverName'],
      driverPhoto: json['driverPhoto'],
      driverPhone: json['driverPhone'],
      pickUpPlace: json['pickUpPlace'],
      dropOffPlace: json['dropOffPlace'],
      rideDate: DateTime.parse(json['rideDate']),
      price: (json['price'] as num).toDouble(),
      status: json['status'],
    );
  }
}
