enum BookingStatus {
  active,
  completed,
  cancelled;

  static BookingStatus fromInt(int value) {
    switch (value) {
      case 0:
        return BookingStatus.active;
      case 1:
        return BookingStatus.completed;
      case 2:
        return BookingStatus.cancelled;
      default:
        return BookingStatus.active;
    }
  }

  int toInt() {
    switch (this) {
      case BookingStatus.active:
        return 0;
      case BookingStatus.completed:
        return 1;
      case BookingStatus.cancelled:
        return 2;
    }
  }

  
}

enum DoctorBookingStatus {
  upComing,
  completed,
  cancelled;

  int toInt() {
    switch (this) {
      case DoctorBookingStatus.upComing:
        return 0;
      case DoctorBookingStatus.completed:
        return 1;
      case DoctorBookingStatus.cancelled:
        return 2;
    }

    
  }
}
