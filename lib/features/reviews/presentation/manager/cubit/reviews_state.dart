part of 'reviews_cubit.dart';

sealed class ReviewsState {}

final class ReviewsInitial extends ReviewsState {}

final class ReviewsUpdate extends ReviewsState {}

final class GetReviewsSuccess extends ReviewsState {}

final class GetReviewsLoading extends ReviewsState {}

final class GetReviewsFailure extends ReviewsState {
  final String errMsg;

  GetReviewsFailure({required this.errMsg});
}

final class AddReviewsuccess extends ReviewsState {}

final class AddReviewLoading extends ReviewsState {}

final class AddReviewFailure extends ReviewsState {
  final String errMsg;

  AddReviewFailure({required this.errMsg});
}

abstract class ReviewActions extends ReviewsState {
  final int reviewId;

  ReviewActions({required this.reviewId});
}

final class DeleteReviewsuccess extends ReviewActions {
  DeleteReviewsuccess({required super.reviewId});
}

final class DeleteReviewLoading extends ReviewActions {
  DeleteReviewLoading({required super.reviewId});
}

final class DeleteReviewFailure extends ReviewActions {
  final String errMsg;

  DeleteReviewFailure({required this.errMsg, required super.reviewId});
}

final class UpdateReviewsuccess extends ReviewActions {
  UpdateReviewsuccess({required super.reviewId});
}

final class UpdateReviewLoading extends ReviewActions {
  UpdateReviewLoading({required super.reviewId});
}

final class UpdateReviewFailure extends ReviewActions {
  final String errMsg;

  UpdateReviewFailure({required this.errMsg, required super.reviewId});
}
