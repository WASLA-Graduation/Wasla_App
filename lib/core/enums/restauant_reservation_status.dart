enum ReservationStatus {
  pending,
  accepted,
  canceled,
  completed;

  static ReservationStatus fromInt(int value) {
    return ReservationStatus.values[value];
  }
}

enum OrderStatus {
  pending,
  paid,
  preparing,
  onTheWay,
  delivered,
  canceled;

  static OrderStatus fromInt(int value) {
    return OrderStatus.values[value];
  }
}
