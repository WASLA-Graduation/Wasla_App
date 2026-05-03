import 'package:wasla/core/models/user_base_model.dart';

class TechnicianModel extends UserBaseModel {
  final String email;
  final String fullName;
  final String phone;
  final String birthDay;
  final int experienceYears;
  final String description;
  final double latitude;
  final double longitude;
  final int specialty;
  final String profilePhotoUrl;
  final List<String> documentsUrls;
  final double rate;
  final bool isAvailable;

  TechnicianModel({
    required this.email,
    required this.fullName,
    required this.phone,
    required this.birthDay,
    required this.experienceYears,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.specialty,
    required this.profilePhotoUrl,
    required this.documentsUrls,
    required this.rate,
    required this.isAvailable,
  }) : super(
         fullNameBase: fullName,
         emailBase: email,
         phoneNumberBase: phone,
         imageUrlBase: profilePhotoUrl,
         latBase: latitude,
         lngBase: longitude,
       );

  factory TechnicianModel.fromJson(Map<String, dynamic> json) {
    return TechnicianModel(
      email: json['email'] ?? '',
      fullName: json['fullName'] ?? '',
      phone: json['phone'] ?? '',
      birthDay: json['birthDay'] ?? '',
      experienceYears: json['experienceYears'] ?? 0,
      description: json['description'] ?? '',
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      specialty: json['specialty'] ?? 0,
      profilePhotoUrl: json['profilePhotoUrl'] ?? '',
      documentsUrls: List<String>.from(json['documentsUrls'] ?? []),
      rate: (json['rate'] as num?)?.toDouble() ?? 0,
      isAvailable: json['isAvailable'] ?? false,
    );
  }


}
