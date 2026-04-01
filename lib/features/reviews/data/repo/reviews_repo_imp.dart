import 'package:dartz/dartz.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/features/reviews/data/models/review_model.dart';
import 'package:wasla/features/reviews/data/repo/reviews_repo.dart';

class ReviewsRepoImpl extends ReviewsRepo {
  final ApiConsumer api;

  ReviewsRepoImpl({required this.api});

  @override
  Future<Either<String, List<ReviewModel>>> getReview({
    required String userId,
  }) async {
    try {
      final response = await api.get(ApiEndPoints.getReviews + userId);
      final List<ReviewModel> reviews = [];
      for (var review in response[ApiKeys.data]) {
        reviews.add(ReviewModel.fromJson(review));
      }
      return Right(reviews);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, Null>> addReview({
    required String userId,
    required String comment,
    required int rating,
    required String serviceProviderId,
  }) async {
    try {
      await api.post(
        ApiEndPoints.addReview,
        body: {
          ApiKeys.userId: userId,
          ApiKeys.content: comment,
          ApiKeys.rating: rating,
          ApiKeys.serviceProviderId: serviceProviderId,
        },
      );
      return Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, Null>> deleteReview({required int reviewId}) async {
    try {
      await api.delete(ApiEndPoints.removeReview + reviewId.toString());
      return Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, Null>> updateReview({
    required int reviewId,
    required String content,
    required int rating,
  }) async {
    try {
      await api.put(
        ApiEndPoints.updateReview,
        body: {
          ApiKeys.content: content,
          ApiKeys.rating: rating,
          ApiKeys.reviewId: reviewId,
        },
      );
      return Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, List<ReviewModel>>> getReviewsByRating({
    required int rating,
    required String serviceProviderId,
  }) async {
    try {
      final response = await api.get(
        "${ApiEndPoints.getReviewsByRating}$rating/service-providers/$serviceProviderId",
      );
      final List<ReviewModel> reviews = [];
      for (var review in response[ApiKeys.data]) {
        reviews.add(ReviewModel.fromJson(review));
      }
      return Right(reviews);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
