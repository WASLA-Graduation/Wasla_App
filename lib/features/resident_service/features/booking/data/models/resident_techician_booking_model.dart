import 'package:wasla/core/enums/technicant_speciality.dart';
import 'package:wasla/core/enums/technician_booking_status.dart';
import 'package:wasla/core/functions/format_date_from_string.dart';
import 'package:wasla/core/functions/format_time_with_intl.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/general_resident_bookings_model.dart';

class ResidentTechicianBookingModel extends GeneralResidentBookingsModel {
  final int bookingId;
  final String technicianName;
  final String technicianPhone;
  final String technicianImage;
  final double price;
  final DateTime bookingDate;
  final int status;
  final int technicianSpeciality;

  ResidentTechicianBookingModel({
    required this.technicianSpeciality,
    required this.bookingId,
    required this.technicianName,
    required this.technicianPhone,
    required this.technicianImage,
    required this.price,
    required this.bookingDate,
    required this.status,
  }) : super(
         baseBookingId: bookingId,
         baseName: technicianName,
         baseServiceName:
             TechnicantSpeciality.values[technicianSpeciality].name,
         baseStatus: TechnicianBookingStatus.getTitle(index: status - 1),
         baseImage: technicianImage,
         baseDate: formatDateBooking(bookingDate),
         baseDuration:
             "${formatDateTimeWithIntl(bookingDate)} | $technicianPhone",
       );

  factory ResidentTechicianBookingModel.fromJson(Map<String, dynamic> json) {
    return ResidentTechicianBookingModel(
      technicianSpeciality: json['technicianSpeciality'] - 1,
      bookingId: json['bookingId'],
      technicianName: json['technicianName'],
      technicianPhone: json['technicianPhone'],
      technicianImage: json['technicianImage'],
      price: (json['price'] as num).toDouble(),
      bookingDate: DateTime.parse(json['bookingDate']),
      status: json['status'],
    );
  }
}
