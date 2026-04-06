enum TechnicantSpeciality {
  plumber,
  electrician,
  carpenter,
  aCTechnician,
  applianceRepair,
  painter,
  satelliteTechnician,
  locksmith,
  glassTechnician,
  flooringTechnician;

  static String getTitle({required int index}) {
    TechnicantSpeciality speciality = TechnicantSpeciality.values[index];
    switch (speciality) {
      case TechnicantSpeciality.plumber:
        return 'plumber';
      case TechnicantSpeciality.electrician:
        return 'electrician';
      case TechnicantSpeciality.carpenter:
        return 'carpenter';
      case TechnicantSpeciality.aCTechnician:
        return 'acTechnician';
      case TechnicantSpeciality.applianceRepair:
        return 'applianceRepair';
      case TechnicantSpeciality.painter:
        return 'painter';
      case TechnicantSpeciality.satelliteTechnician:
        return 'satelliteTechnician';
      case TechnicantSpeciality.locksmith:
        return 'locksmith';
      case TechnicantSpeciality.glassTechnician:
        return 'glassTechnician';
      case TechnicantSpeciality.flooringTechnician:
        return 'flooringTechnician';
    }
  }
}
