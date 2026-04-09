enum BookingFilter {
  doctorBookings,
  gymBookings,
  driverBookings,
  technicianBookings,
  restaurantBookings;

  int toInt() {
    return index;
  }

  static BookingFilter fromInt(int value) {
    if (value >= 0 && value < BookingFilter.values.length) {
      return BookingFilter.values[value];
    }
    return BookingFilter.doctorBookings;
  }

  String toTitle() {
    switch (this) {
      case BookingFilter.doctorBookings:
        return "all_doctor_bookings";
      case BookingFilter.gymBookings:
        return "all_gym_bookings";
      case BookingFilter.restaurantBookings:
        return "all_return_bookings";
      case BookingFilter.driverBookings:
        return "all_driver_bookings";
      case BookingFilter.technicianBookings:
        return "all_technician_bookings";
    }
  }

  static String titleFromIndex(int index) {
    if (index >= 0 && index < BookingFilter.values.length) {
      return BookingFilter.values[index].toTitle();
    }
    return "all_doctor_bookings"; // default
  }
}
