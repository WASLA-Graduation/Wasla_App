import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';

class DoctorDataModel {
  final String id;
  final String fullName;
  final String specialtyName;
  final int experienceYears;
  final double rating;
  final String universityName;
  final int graduationYear;
  final String hospitalname;
  final int numberOfpatients;
  final String birthDay;
  final String phone;
  final double latitude;
  final double longitude;
  final String description;
  final String imageUrl;
  final String cvUrl;

  DoctorDataModel({
    required this.id,
    required this.fullName,
    required this.specialtyName,
    required this.experienceYears,
    required this.rating,
    required this.universityName,
    required this.graduationYear,
    required this.hospitalname,
    required this.numberOfpatients,
    required this.birthDay,
    required this.phone,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.imageUrl,
    required this.cvUrl,
  });

  factory DoctorDataModel.fromJson(Map<String, dynamic> json) {
    return DoctorDataModel(
      id: json[ApiKeys.id] ?? '',
      fullName: json[ApiKeys.fullNameCamel] ?? '',
      specialtyName: json[ApiKeys.specialtyName] ?? '',
      experienceYears: json[ApiKeys.experienceYearsCamel] ?? 0,
      rating: (json[ApiKeys.rating] ?? 0).toDouble(),
      universityName: json[ApiKeys.universityNameCamel] ?? '',
      graduationYear: json[ApiKeys.graduationYearCamel] ?? 0,
      hospitalname: json[ApiKeys.hospitalname] ?? '',
      numberOfpatients: json[ApiKeys.numberOfpatients] ?? 0,
      birthDay: json[ApiKeys.birthDayCamel] ?? '',
      phone: json[ApiKeys.phoneSmall] ?? '',
      latitude: (json[ApiKeys.latitudeSmall] ?? 0).toDouble(),
      longitude: (json[ApiKeys.longitudeSmall] ?? 0).toDouble(),
      description: json[ApiKeys.descriptionSmall] ?? '',
      imageUrl: (json[ApiKeys.imageUrl] != null && json[ApiKeys.imageUrl] != ''
          ? ApiEndPoints.imageBaseUrl + json[ApiKeys.imageUrl]
          : ''),
      cvUrl: json[ApiKeys.cvUrl] ?? '',
    );
  }
}
