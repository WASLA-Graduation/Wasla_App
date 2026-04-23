import 'package:wasla/core/enums/restauant_reservation_status.dart';

class RestaurantReservationModel {
  final int id;
  final String userId;
  final String name;
  final String profile;
  final String phone;
  final String restaurantId;
  final int numberOfPersons;
  final DateTime reservationDate;
  final String reservationTime;
  ReservationStatus status;

  RestaurantReservationModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.profile,
    required this.phone,
    required this.restaurantId,
    required this.numberOfPersons,
    required this.reservationDate,
    required this.reservationTime,
    required this.status,
  });

  factory RestaurantReservationModel.fromJson(Map<String, dynamic> json) {
    return RestaurantReservationModel(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      profile: json['profile'],
      phone: json['phone'],
      restaurantId: json['restaurantId'],
      numberOfPersons: json['numberOfPersons'],
      reservationDate: DateTime.parse(json['reservationDate']),
      reservationTime: json['reservationTime'],
      status: ReservationStatus.values[json['status']],
    );
  }
}
