import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';

class ReviewModel {
  final int reviewId;
  final String userId;
  final String reviewerName;
  final String userImageUrl;
  final int rating;
   String comment;
  final DateTime createdAt;

  ReviewModel({
    required this.reviewId,
    required this.userId,
    required this.reviewerName,
    required this.userImageUrl,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      reviewId: json[ApiKeys.reviewId] ?? 0,
      userId: json[ApiKeys.userId] ?? '',
      reviewerName: json[ApiKeys.reviewerName] ?? '',
      userImageUrl: ApiEndPoints.imageBaseUrl+ json[ApiKeys.userImageUrl] ,
      rating: json[ApiKeys.rating] ?? 0,
      comment: json[ApiKeys.comment] ?? '',
      createdAt: DateTime.parse(
        json[ApiKeys.createdAt] ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}
