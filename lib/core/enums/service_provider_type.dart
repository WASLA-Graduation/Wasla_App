enum ServiceProviderTypeEnum {
  doctor,
  restaurant,
  driver,
  gym;

  static ServiceProviderTypeEnum fromStringToServiceProviderType(String value) {
    return ServiceProviderTypeEnum.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
    );
  }
}
