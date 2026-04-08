enum TechnicianBookingStatus {
  pending,
  accepted,
  cancelled,
  completed;

  static String getTitle({required int index}) {
    TechnicianBookingStatus status = TechnicianBookingStatus.values[index];
    return status.name;
  }
}
