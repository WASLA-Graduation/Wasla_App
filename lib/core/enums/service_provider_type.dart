enum ServiceProviderTypeEnum {
  doctor,
  restaurant,
  driver,
  gym,
  technician;

  static ServiceProviderTypeEnum fromStringToServiceProviderType(String value) {
    return ServiceProviderTypeEnum.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
    );
  }
}
