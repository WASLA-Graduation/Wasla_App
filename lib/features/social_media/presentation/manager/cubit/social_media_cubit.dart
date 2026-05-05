import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/report_enum.dart';
import 'package:wasla/core/enums/social_enums.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/service/service_locator.dart';
import 'package:wasla/core/utils/app_colors.dart';

import 'package:wasla/features/social_media/data/models/social_comment_model.dart';
import 'package:wasla/features/social_media/data/models/social_post_model.dart';
import 'package:wasla/features/social_media/data/models/social_profile_model.dart';
import 'package:wasla/features/social_media/data/models/update_post_model.dart';
import 'package:wasla/features/social_media/data/repo/social_media_repo.dart';

part 'social_media_state.dart';

class SocialMediaCubit extends Cubit<SocialMediaState> {
  SocialMediaCubit(this.socialMediaRepo) : super(SocialMediaInitial());

  final SocialMediaRepo socialMediaRepo;

  List<File> postsImages = [];
  List<SocialPostModel> allPosts = [];
  List<CommentModel> postComments = [];
  int userPageSize = 10;
  int userPageNumber = 1;
  bool userEndOfPosts = false;

  SocialProfileModel? userProfile;
  SocialProfileModel? currentUserProfile;

  List<SocialPostModel> userPosts = [];
  int userProfileCurrentTap = 0;

  TextEditingController commentController = TextEditingController();
  UpdatePostModel updatePostModel = UpdatePostModel();

  int pageNumber = 1;
  int pageSize = 10;
  bool endOfPosts = false;
  int commentPageNumber = 1;
  int commentPageSize = 10;
  bool endOfComments = false;
  String postContent = '';
  String commentContent = '';
  String currentUser = '';

  ReportReason reportReason = ReportReason.none;

  Map<int, int> postDotIndex = {};

  void chooseReport({required ReportReason reportReason}) {
    this.reportReason = reportReason;
    emit(SocialChooseReportState());
  }

  void onRetry() {
    emit(SocialMediaOnRetryState());
  }

  Future<void> getCurrentUser() async {
    currentUser = await getUserId() ?? '';
  }

  void updatePostImages({List<File>? newImages, List<String>? oldImages}) {
    if (newImages != null) {
      updatePostModel.newImages.addAll(newImages);
    }
    if (oldImages != null) {
      updatePostModel.oldImages = oldImages;
    }
    emit(UpateChoosedImages());
  }

  void deletePostImage({dynamic image}) {
    image is File
        ? updatePostModel.newImages.remove(image)
        : updatePostModel.oldImages.remove(image);
    emit(UpateChoosedImages());
  }

  int selectedPostId = -1;
  void changeTapIndex({
    required int index,
    required PostType postType,
    required String userId,
  }) {
    if (index == userProfileCurrentTap) return;
    userProfileCurrentTap = index;
    userPageNumber = 1;
    userPageSize = 10;
    userEndOfPosts = false;
    userPosts = [];
    switch (postType) {
      case PostType.post:
        getUserPosts(fromPagination: false, userId: userId);
      case PostType.love:
        getUserPostsByReaction(
          fromPagination: false,
          userId: userId,
          reactionType: ReactionType.love,
        );
      case PostType.save:
        getUserPostsByReaction(
          fromPagination: false,
          userId: userId,
          reactionType: ReactionType.save,
        );
    }
  }

  void onPostImageChange({required int index, required int postId}) {
    postDotIndex[postId] = index;
    selectedPostId = postId;
    emit(UpdateCurrentPostDotIndex());
  }

  void updateChoosedPostImages(List<File> images) {
    postsImages = images;
    emit(UpateChoosedImages());
  }

  Future<void> getAllPosts({required bool fromPagination}) async {
    if (endOfPosts ||
        (fromPagination && state is GetAllPostsPaginationLoading)) {
      return;
    }

    if (fromPagination) {
      emit(GetAllPostsPaginationLoading());
    } else {
      emit(GetAllPostsLoading());
    }

    final String? userId = await getUserId();
    final result = await socialMediaRepo.getAllPosts(
      currentUserId: userId!,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
    result.fold(
      (failure) {
        if (failure is NoInternetFailure) {
          emit(SocialMediaNetworkState());
        } else {
          emit(SocialMediaFailureState());
        }
      },
      (posts) {
        if (posts.isEmpty) {
          endOfPosts = true;
          emit(GetAllPostsSuccess());
        } else {
          pageNumber++;
          allPosts.addAll(posts);
          emit(GetAllPostsSuccess());
        }
      },
    );
  }

  Future<void> toggleReaction({
    required ReactionType reactionType,
    required TargetType targetType,

    dynamic item,
  }) async {
    final String? userId = await getUserId();
    switch (targetType) {
      case TargetType.post:
        item = item as SocialPostModel;
        switch (reactionType) {
          case ReactionType.love:
            item.isLoved = !item.isLoved;
            item.numberOfReacts += item.isLoved ? 1 : -1;
            selectedPostId = item.postId;

            break;
          case ReactionType.save:
            item.isSaved = !item.isSaved;
            item.numberOfSaves += item.isSaved ? 1 : -1;
            break;
        }

        selectedPostId = item.postId;

        break;
      case TargetType.comment:
        item = item as CommentModel;
        item.isLove = !item.isLove;
        item.numberOfLikes += item.isLove ? 1 : -1;
        selectedPostId = item.commentId;

        break;
    }
    emit(ToggleReactionState());

    await socialMediaRepo.toggleReaction(
      userId: userId!,
      targetId: item is SocialPostModel ? item.postId : item.commentId,
      targetType: targetType.index + 1,
      reactionType: reactionType.index + 1,
    );
  }

  Future<void> getPostComments({
    required int postId,
    required bool fromPagination,
  }) async {
    if (endOfComments ||
        (fromPagination && state is GetCommentsPaginationLoading)) {
      return;
    }

    if (fromPagination) {
      emit(GetCommentsPaginationLoading());
    } else {
      emit(GetCommentsLoading());
    }

    final String? userId = await getUserId();
    final result = await socialMediaRepo.getAllPostComments(
      currentUserId: userId!,
      postId: postId,
      pageNumber: commentPageNumber,
      pageSize: commentPageSize,
    );
    result.fold(
      (failure) {
        if (failure is NoInternetFailure) {
          emit(SocialMediaNetworkState());
        } else {
          emit(SocialMediaFailureState());
        }
      },
      (comments) {
        if (comments.isEmpty) {
          endOfComments = true;
          emit(GetCommentsSuccess());
        } else {
          commentPageNumber++;
          postComments.addAll(comments);
          emit(GetCommentsSuccess());
        }
      },
    );
  }

  Future<void> addPost() async {
    if (postContent.isEmpty && postsImages.isEmpty) {
      return;
    }

    emit(AddPostLoading());
    final String? userId = await getUserId();
    final result = await socialMediaRepo.addPost(
      userId: userId!,
      content: postContent,
      images: postsImages,
    );
    result.fold((failure) => emit(AddPostFailure(errorMessage: failure)), (
      posts,
    ) {
      reset();
      getAllPosts(fromPagination: false);
      emit(AddPostSuccess());
    });
  }

  Future<void> addComment({required int postId}) async {
    selectedPostId = postId;
    final String? userId = await getUserId();
    final result = await socialMediaRepo.addComment(
      userId: userId!,
      content: commentContent,
      postId: postId,
    );
    result.fold((failure) => emit(AddCommentFailure(errorMessage: failure)), (
      posts,
    ) {
      int postIndex = allPosts.indexWhere((post) => post.postId == postId);
      allPosts[postIndex].numberofComments++;
      postComments = [];
      commentPageNumber = 1;
      commentPageSize = 10;
      endOfComments = false;
      getPostComments(fromPagination: false, postId: postId);
    });
  }

  Future<void> deletePost({required SocialPostModel myPost}) async {
    final SocialPostModel post = myPost;
    final int postIndex = allPosts.indexWhere(
      (post) => post.postId == myPost.postId,
    );
    final int userPostIndex = userPosts.indexWhere(
      (post) => post.postId == myPost.postId,
    );

    if (postIndex != -1) {
      allPosts.removeWhere((post) => post.postId == myPost.postId);
    }
    if (userPostIndex != -1) {
      userPosts.removeWhere((post) => post.postId == myPost.postId);
    }

    if (userProfile?.profilePhoto == myPost.profilePhoto) {
      userProfile?.postsCount--;
    }

    emit(DeletePostLoading());
    final result = await socialMediaRepo.deletePost(postId: myPost.postId);
    result.fold((failure) {
      if (postIndex != -1) {
        allPosts.insert(postIndex, post);
      }
      if (userPostIndex != -1) {
        userPosts.insert(userPostIndex, post);
      }
      if (userProfile?.profilePhoto == myPost.profilePhoto) {
        userProfile?.postsCount++;
      }
      emit(DeletePostFailure(errorMessage: failure));
    }, (posts) => null);
  }

  Future<void> deleteComment({
    required CommentModel targetComment,
    required int postId,
  }) async {
    selectedPostId = postId;
    final comment = targetComment;
    final int commentIndex = postComments.indexOf(comment);

    if (commentIndex != -1) {
      postComments.remove(comment);
      int postIndex = allPosts.indexWhere((post) => post.postId == postId);
      int userPostIndex = userPosts.indexWhere((post) => post.postId == postId);
      if (postIndex != -1) {
        allPosts[postIndex].numberofComments--;
      }
      if (userPostIndex != -1) {
        userPosts[userPostIndex].numberofComments--;
      }
    }

    emit(DeleteCommentLoading());
    final result = await socialMediaRepo.deleteComment(
      commentId: targetComment.commentId,
    );
    result.fold((failure) {
      if (commentIndex != -1) {
        postComments.insert(commentIndex, comment);
        int postIndex = allPosts.indexWhere((post) => post.postId == postId);
        int userPostIndex = userPosts.indexWhere(
          (post) => post.postId == postId,
        );

        if (postIndex != -1) {
          allPosts[postIndex].numberofComments++;
        }
        if (userPostIndex != -1) {
          userPosts[userPostIndex].numberofComments++;
        }
        emit(DeleteCommentFailure(errorMessage: failure));
      }
    }, (comments) {});
  }

  Future<void> getUserPosts({
    required bool fromPagination,
    required String userId,
  }) async {
    if (userEndOfPosts ||
        (fromPagination && state is GetUserPostsPaginationLoading)) {
      return;
    }

    if (fromPagination) {
      emit(GetUserPostsPaginationLoading());
    } else {
      emit(GetUserPostsLoading());
    }

    final String? currentUserId = await getUserId();
    final result = await socialMediaRepo.getPostsOfUser(
      currentUserId: currentUserId!,
      pageNumber: userPageNumber,
      pageSize: userPageSize,
      userId: userId,
    );
    result.fold(
      (failure) {
        if (failure is NoInternetFailure) {
          emit(SocialMediaNetworkState());
        } else {
          emit(SocialMediaFailureState());
        }
      },
      (posts) {
        if (posts.isEmpty) {
          userEndOfPosts = true;
          emit(GetUserPostsSuccess());
        } else {
          userPageNumber++;
          userPosts.addAll(posts);
          emit(GetUserPostsSuccess());
        }
      },
    );
  }

  Future<void> getUserPostsByReaction({
    required bool fromPagination,
    required String userId,
    required ReactionType reactionType,
  }) async {
    if (userEndOfPosts ||
        (fromPagination && state is GetUserPostsPaginationLoading)) {
      return;
    }

    if (fromPagination) {
      emit(GetUserPostsPaginationLoading());
    } else {
      emit(GetUserPostsLoading());
    }

    final result = await socialMediaRepo.getPostsOfUserByReactionType(
      pageNumber: userPageNumber,
      pageSize: userPageSize,
      userId: userId,
      reactionType: reactionType.index + 1,
    );
    result.fold(
      (failure) {
        if (failure is NoInternetFailure) {
          emit(SocialMediaNetworkState());
        } else {
          emit(SocialMediaFailureState());
        }
      },
      (posts) {
        if (posts.isEmpty) {
          userEndOfPosts = true;
          emit(GetUserPostsSuccess());
        } else {
          userPageNumber++;
          userPosts.addAll(posts);
          emit(GetUserPostsSuccess());
        }
      },
    );
  }

  Future<void> getUserProfile({required String userId}) async {
    emit(GetUserProfileLoading());

    final result = await socialMediaRepo.getUserProfile(userId: userId);
    result.fold(
      (failure) {
        if (failure is NoInternetFailure) {
          emit(SocialMediaNetworkState());
        } else {
          emit(SocialMediaFailureState());
        }
      },
      (userProfile) {
        if (currentUser == userId) {
          currentUserProfile = userProfile;
        } else {
          this.userProfile = userProfile;
        }
        emit(GetUserProfileSuccess());
      },
    );
  }

  Future<void> updateComment({required CommentModel comment}) async {
    selectedPostId = comment.commentId;
    final result = await socialMediaRepo.updateComment(
      commentId: comment.commentId,
      content: commentContent,
    );
    result.fold(
      (failure) => emit(UpdateCommentFailure(errorMessage: failure)),
      (_) {
        postComments
                .firstWhere((element) => element.commentId == comment.commentId)
                .content =
            commentContent;
        emit(UpdateCommentSuccess());
      },
    );
  }

  Future<void> updatePost({required int postId}) async {
    emit(UpdatePostLoading());
    selectedPostId = postId;
    final result = await socialMediaRepo.updatePost(
      id: postId,
      updatePostImages: updatePostModel,
      content: postContent,
    );

    result.fold((error) => emit(UpdatePostFailure(errorMessage: error)), (
      success,
    ) async {
      final myPost = allPosts.firstWhere((post) => post.postId == postId);
      myPost.content = postContent;
      myPost.newImages = updatePostModel.newImages;
      myPost.files = updatePostModel.oldImages;
      if (userPosts.isNotEmpty) {
        final myPost = userPosts.firstWhere((post) => post.postId == postId);
        myPost.content = postContent;
        myPost.newImages = updatePostModel.newImages;
        myPost.files = updatePostModel.oldImages;
      }
      postContent = '';
      updatePostModel.newImages = [];
      updatePostModel.oldImages = [];
      emit(UpdatePostSuccess());
    });
  }

  Future<void> reportForSomething({
    required int targetId,
    required TargetType targetType,
    required String reason,
  }) async {
    emit(SocialReportLoadingState());
    final String? currentUserId = await getUserId();
    final result = await socialMediaRepo.reportForSomething(
      userId: currentUserId!,
      targetId: targetId,
      targetType: targetType,
      reason: reason,
    );
    result.fold(
      (failure) {
        toastAlert(color: AppColors.error, msg: failure);

        reportReason = ReportReason.none;
        emit(SocialReportFailureState(errorMessage: failure));
      },
      (_) {
        toastAlert(
          color: AppColors.green,
          msg: 'reportSuccess'.tr(navigatorKey.currentContext!),
        );

        reportReason = ReportReason.none;
        emit(SocialReportSucessState());
      },
    );
  }

  void reset() {
    postsImages = [];
    allPosts = [];
    postComments = [];
    postContent = '';
    userProfileCurrentTap = 0;
    pageNumber = 1;
    pageSize = 10;
    endOfPosts = false;
    selectedPostId = -1;
    postDotIndex = {};
    commentPageNumber = 1;
    commentPageSize = 10;
    endOfComments = false;
  }
}
