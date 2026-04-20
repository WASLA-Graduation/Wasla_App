enum ReservationStatus {
  pending,
  accepted,
  canceled,
  completed;

  static ReservationStatus fromInt(int value) {
    return ReservationStatus.values[value];
  }
}
