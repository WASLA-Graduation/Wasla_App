import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/models/user_base_model.dart';

class GymModel extends UserBaseModel {
  final String id;
  final String businessName;
  final String ownerName;
  final String email;
  final String description;
  final List<String> phones;
  final String profilePhoto;
  final List<String> photos;
  final int reviewsCount;
  final double rating;

  GymModel({
    required this.id,
    required this.businessName,
    required this.ownerName,
    required this.email,
    required this.description,
    required this.phones,
    required this.profilePhoto,
    required this.photos,
    required this.reviewsCount,
    required this.rating,
  }) : super(
         fullNameBase: ownerName,
         emailBase: email,
         phoneNumberBase: profilePhoto,
         imageUrlBase: profilePhoto,
         latBase: 0.0,
         lngBase: 0.0,
       );

  factory GymModel.fromJson(Map<String, dynamic> json) {
    return GymModel(
      id: json[ApiKeys.id] ?? '',
      businessName: json[ApiKeys.businessName] ?? '',
      ownerName: json[ApiKeys.ownerName] ?? '',
      email: json[ApiKeys.email] ?? "",
      description: json[ApiKeys.descriptionSmall] ?? '',
      phones: List<String>.from(json[ApiKeys.phones] ?? []),
      profilePhoto: json[ApiKeys.profilePhoto] == null
          ? ''
          : ApiEndPoints.gymBaseUrl + json[ApiKeys.profilePhoto],
      photos: List<String>.from(
        json[ApiKeys.photos] != null
            ? json[ApiKeys.photos].map(
                (photo) => ApiEndPoints.gymBaseUrl + photo,
              )
            : [],
      ),
      reviewsCount: json[ApiKeys.reviewsCount] ?? 0,
      rating: (json[ApiKeys.rating] as num?)?.toDouble() ?? 0.0,
    );
  }
}
