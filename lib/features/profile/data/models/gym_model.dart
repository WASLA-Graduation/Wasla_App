import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';

class GymModel {
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
  });

  factory GymModel.fromJson(Map<String, dynamic> json) {
    return GymModel(
      id: json[ApiKeys.id],
      businessName: json[ApiKeys.businessName],
      ownerName: json[ApiKeys.ownerName],
      email: json[ApiKeys.email],
      description: json[ApiKeys.description],
      phones: List<String>.from(json[ApiKeys.phones] ?? []),
      profilePhoto: json[ApiKeys.profilePhoto],
      photos: List<String>.from(
        json[ApiKeys.photos] != null
            ? json[ApiKeys.photos].map(
                (photo) => ApiEndPoints.imageBaseUrl + photo,
              )
            : [],
      ),
      reviewsCount: json[ApiKeys.reviewsCount] ?? 0,
      rating: (json[ApiKeys.rating] as num?)?.toDouble() ?? 0.0,
    );
  }
}
