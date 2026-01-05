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

final class DeleteReviewsuccess extends ReviewsState {}

final class DeleteReviewLoading extends ReviewsState {}

final class DeleteReviewFailure extends ReviewsState {
  final String errMsg;

  DeleteReviewFailure({required this.errMsg});
}

final class UpdateReviewsuccess extends ReviewsState {}

final class UpdateReviewLoading extends ReviewsState {}

final class UpdateReviewFailure extends ReviewsState {
  final String errMsg;

  UpdateReviewFailure({required this.errMsg});
}
