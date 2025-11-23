import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/models/user_base_model.dart';

class DoctorModel extends UserBaseModel {
  final String fullName,
      email,
      specializationName,
      universityName,
      birthDay,
      phone,
      description,
      image,
      cv;

  final int experienceYears, graduationYear;
  final double latitude, longitude;

  DoctorModel({
    required this.fullName,
    required this.email,
    required this.specializationName,
    required this.universityName,
    required this.birthDay,
    required this.phone,
    required this.description,
    required this.image,
    required this.cv,
    required this.experienceYears,
    required this.graduationYear,
    required this.latitude,
    required this.longitude,
  }) : super(
         fullNameBase: fullName,
         emailBase: email,
         phoneNumberBase: phone,
         imageUrlBase: image,
         latBase: latitude,
         lngBase: longitude,
       );

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      fullName: json[ApiKeys.fullNameCamel],
      email: json[ApiKeys.email],
      specializationName: json[ApiKeys.specializationName],
      universityName: json[ApiKeys.universityNameCamel],
      birthDay: json[ApiKeys.birthDayCamel],
      phone: json[ApiKeys.phoneSmall],
      description: json[ApiKeys.descriptionSmall],
      image: ApiEndPoints.imageBaseUrl + json[ApiKeys.imageSmall],
      cv: json[ApiKeys.cvSmall],
      experienceYears: json[ApiKeys.experienceYearsCamel],
      graduationYear: json[ApiKeys.graduationYearCamel],
      latitude: json[ApiKeys.latitudeSmall].toDouble(),
      longitude: json[ApiKeys.longitudeSmall].toDouble(),
    );
  }
}
