import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/features/reviews/data/models/review_model.dart';
import 'package:wasla/features/reviews/data/repo/reviews_repo.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final ReviewsRepo reviewsRepo;
  ReviewsCubit(this.reviewsRepo) : super(ReviewsInitial());
  List<ReviewModel> reviewList = [];
  final reviewValueController = TextEditingController();
  final reviewEditValueController = TextEditingController();
  Set<int> starsIds = {};
  String reviewValue = '';
  int ratingIndex = 0;
  String? selectedUserId;

  void updateReviewValue(String value) {
    reviewValue = value;
    if (value.length <= 1) {
      emit(ReviewsUpdate());
    }
  }

  void toggleRatingStars(int index) {
    if (starsIds.contains(index)) {
      starsIds.remove(index);
    } else {
      starsIds.add(index);
    }
    emit(ReviewsUpdate());
  }

  void changeRatingIndex(int index, int rating) {
    ratingIndex = index;
    if (index == 0) {
      getReveiws(selectedUserId!);
    } else {
      getReveiwsByRating(rating);
    }
  }

  Future<void> getReveiws(String currentUserId) async {
    emit(GetReviewsLoading());

    reviewList.clear();
    final response = await reviewsRepo.getReview(userId: currentUserId);
    response.fold(
      (error) {
        emit(GetReviewsFailure(errMsg: error));
      },
      (success) {
        reviewList = success;
        // reviewsByRatingList = reviewList;
        emit(GetReviewsSuccess());
      },
    );
  }

  Future<void> addReview(String serviceProviderId) async {
    emit(AddReviewLoading());
    String? userId = await getUserId();
    final response = await reviewsRepo.addReview(
      comment: reviewValue,
      rating: starsIds.isEmpty ? 4 : starsIds.length,
      serviceProviderId: serviceProviderId,
      userId: userId!,
    );
    response.fold(
      (error) {
        emit(AddReviewFailure(errMsg: error));
      },
      (success) {
        reviewValue = "";
        getReveiws(serviceProviderId);
      },
    );
  }

  Future<void> deleteReview({required int reviewId}) async {
    emit(DeleteReviewLoading());
    final response = await reviewsRepo.deleteReview(reviewId: reviewId);
    response.fold(
      (error) {
        emit(DeleteReviewFailure(errMsg: error));
      },
      (success) {
        reviewList.removeWhere((element) => element.reviewId == reviewId);
        emit(DeleteReviewsuccess());
      },
    );
  }

  Future<void> updateReview({required ReviewModel selectedReveiw}) async {
    emit(UpdateReviewLoading());

    final response = await reviewsRepo.updateReview(
      reviewId: selectedReveiw.reviewId,
      content: reviewValue,
      rating: selectedReveiw.rating,
    );
    response.fold(
      (error) {
        emit(UpdateReviewFailure(errMsg: error));
      },
      (success) {
        for (var review in reviewList) {
          if (review.reviewId == selectedReveiw.reviewId) {
            review.comment = reviewValue;
          }
        }
        reviewValue = "";

        emit(UpdateReviewsuccess());
      },
    );
  }

  Future<void> getReveiwsByRating(int rating) async {
    emit(GetReviewsLoading());

    reviewList.clear();
    final response = await reviewsRepo.getReviewsByRating(rating: rating);
    response.fold(
      (error) {
        emit(GetReviewsFailure(errMsg: error));
      },
      (success) {
        reviewList = success;
        emit(GetReviewsSuccess());
      },
    );
  }

  void resetState() {
    reviewValue = "";
    starsIds = {};
    reviewValueController.clear();
    ratingIndex = 0;
  }
}
