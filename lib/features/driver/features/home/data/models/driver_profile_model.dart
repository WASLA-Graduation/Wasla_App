import 'package:wasla/core/models/user_base_model.dart';

class DriverProfileModel extends UserBaseModel {
  final String email;
  final String fullName;
  final String phone;
  final String vehicleNumber;
  final int drivingExperienceYears;
  final int tripsCount;
  final int vehicleType;
  final double rate;
  final String birthDay;
  final double latitude;
  final double longitude;
  final String description;
  final String profilePhoto;
  final String status;
  final List<String> carImages;
  final List<String> driverFiles;

  DriverProfileModel({
    required this.email,
    required this.fullName,
    required this.phone,
    required this.vehicleNumber,
    required this.drivingExperienceYears,
    required this.tripsCount,
    required this.vehicleType,
    required this.rate,
    required this.birthDay,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.profilePhoto,
    required this.status,
    required this.carImages,
    required this.driverFiles,
  }) : super(
         fullNameBase: fullName,
         emailBase: email,
         phoneNumberBase: phone,
         imageUrlBase: profilePhoto,
         latBase: latitude,
         lngBase: longitude,
       );

  factory DriverProfileModel.fromJson(Map<String, dynamic> json) {
    return DriverProfileModel(
      email: json['email'] ?? '',
      fullName: json['fullName'] ?? '',
      phone: json['phone'] ?? '',
      vehicleNumber: json['vehicleNumber'] ?? '',
      drivingExperienceYears: json['drivingExperienceYears'] ?? 0,
      tripsCount: json['tripsCount'] ?? 0,
      vehicleType: json['vehicleType'] ?? 0,
      rate: (json['rate'] as num).toDouble(),
      birthDay: json['birthDay'] ?? 0,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      description: json['description'] ?? '',
      profilePhoto: json['profilePhoto'] ?? '',
      status: json['status'] ?? '',
      carImages: List<String>.from(json['carImages'] ?? []),
      driverFiles: List<String>.from(json['driverFiles'] ?? []),
    );
  }
}
