import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';

class UserModel {
  final String fullName, email, phoneNumber, imageUrl;
  final double lat, lng;

  UserModel({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.imageUrl,
    required this.lat,
    required this.lng,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json[ApiKeys.fullname],
      email: json[ApiKeys.email],
      phoneNumber: json[ApiKeys.phoneNumber],
      imageUrl: ApiEndPoints.imageBaseUrl + json[ApiKeys.imageUrl],
      lat: json[ApiKeys.latitudeSmall].toDouble(),
      lng: json[ApiKeys.longitudeSmall].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.fullname: fullName,
      ApiKeys.email: email,
      ApiKeys.phoneNumber: phoneNumber,
      ApiKeys.imageUrl: imageUrl,
      ApiKeys.latitudeSmall: lat,
      ApiKeys.longitudeSmall: lng,
    };
  }

  UserModel copyWith({
    String? fullName,
    String? email,
    String? phoneNumber,
    String? imageUrl,
    double? lat,
    double? lng,
  }) {
    return UserModel(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imageUrl: imageUrl ?? this.imageUrl,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }
}
