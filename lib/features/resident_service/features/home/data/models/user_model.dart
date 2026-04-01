import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/models/user_base_model.dart';

class UserModel extends UserBaseModel {
  final String fullName, email, phoneNumber, imageUrl;
  final double lat, lng;

  UserModel({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.imageUrl,
    required this.lat,
    required this.lng,
  }) : super(
         fullNameBase: fullName,
         emailBase: email,
         phoneNumberBase: phoneNumber,
         imageUrlBase: imageUrl,
         latBase: lat,
         lngBase: lng,
       );

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
}
