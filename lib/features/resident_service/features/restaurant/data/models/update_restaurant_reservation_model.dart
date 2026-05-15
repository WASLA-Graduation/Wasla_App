
import 'package:flutter/material.dart';

class UpdateRestaurantReservationModel {
  final int reservationId;
  final DateTime reservationDate;
  final TimeOfDay reservationTime;
  final int numberOfPersons;

  UpdateRestaurantReservationModel({
    required this.reservationId,
    required this.reservationDate,
    required this.reservationTime,
    required this.numberOfPersons,
  });
}
