enum ServiceRole {
  resident,
  driver,
  doctor,
  technician,
  restaurantOwner,
  gymOwner;

  static fromString(String value) {
    if (value == 'gym') return ServiceRole.gymOwner;
    if (value == 'restaurant') return ServiceRole.restaurantOwner;
    return ServiceRole.values.firstWhere((e) => e.name == value);
  }
}
