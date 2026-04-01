enum VehicleType {
  car,
  scooter;

  static String getTitle(int index) {
    final vehicleType = VehicleType.values[index];
    switch (vehicleType) {
      case VehicleType.car:
        return "car";
      case VehicleType.scooter:
        return "scooter";
    }
  }

  static VehicleType formInt(int index) {
    return VehicleType.values[index];
  }
}
