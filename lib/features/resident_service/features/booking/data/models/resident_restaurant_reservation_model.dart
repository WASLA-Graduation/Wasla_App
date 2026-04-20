import 'package:wasla/core/enums/restauant_reservation_status.dart';
import 'package:wasla/core/functions/format_date_from_string.dart';
import 'package:wasla/core/functions/format_time_with_intl.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/general_resident_bookings_model.dart';

class ReservationModel extends GeneralResidentBookingsModel {
  final int id;
  final String restaurantId;
  final int numberOfPersons;
  final String restaurantName;
  final String restaurantProfile;
  final String restaurantPhone;
  final String reservationDate;
  final String reservationTime;
  final ReservationStatus status;

  ReservationModel({
    required this.id,
    required this.restaurantId,
    required this.numberOfPersons,
    required this.restaurantName,
    required this.restaurantProfile,
    required this.restaurantPhone,
    required this.reservationDate,
    required this.reservationTime,
    required this.status,
  }) : super(
         baseBookingId: id,
         baseName: restaurantName,
         baseServiceName: '$numberOfPersons Persons ',
         baseStatus: status.name,
         baseImage: restaurantProfile,
         baseDate: '${formatDateBooking(DateTime.parse(reservationDate))} | ${convertBackendTimeToAmPm(reservationTime)}',
         baseDuration: restaurantPhone,
       );

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      id: json['id'],
      restaurantId: json['restaurantId'],
      numberOfPersons: json['numberOfPersons'],
      restaurantName: json['restaurantName'],
      restaurantProfile: json['restaurantProfile'],
      restaurantPhone: json['restaurantPhone'],
      reservationDate: json['reservationDate'],
      reservationTime: json['reservationTime'],
      status: ReservationStatus.fromInt(json['status']),
    );
  }
}
