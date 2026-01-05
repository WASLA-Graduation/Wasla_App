import 'package:dartz/dartz.dart';
import 'package:wasla/features/reviews/data/models/review_model.dart';

abstract class ReviewsRepo {
    Future<Either<String, Null>> addReview({
    required String userId,
    required String comment,
    required int rating,
    required String serviceProviderId,
  });

  Future<Either<String, List<ReviewModel>>> getReview({required String userId});
  Future<Either<String, Null>> deleteReview({required int reviewId});
  Future<Either<String, Null>> updateReview({
    required int reviewId,
    required String content,
    required int rating,
  });
    Future<Either<String, List<ReviewModel>>> getReviewsByRating({required int rating});
}