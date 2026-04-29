part of 'social_media_cubit.dart';

sealed class SocialMediaState {}

final class SocialMediaInitial extends SocialMediaState {}


////basic  3 states

final class SocialMediaNetworkState extends SocialMediaState {}
final class SocialMediaFailureState extends SocialMediaState {}
final class SocialMediaOnRetryState extends SocialMediaState {}


final class UpdateCurrentTapState extends SocialMediaState {}

final class UpdateCurrentPostDotIndex extends SocialMediaState {}

final class ToggleReactionState extends SocialMediaState {}

final class UpateChoosedImages extends SocialMediaState {}

final class GetAllPostsLoading extends SocialMediaState {}

final class GetAllPostsPaginationLoading extends SocialMediaState {}

final class GetAllPostsSuccess extends SocialMediaState {}



final class GetCommentsLoading extends SocialMediaState {}

final class GetCommentsPaginationLoading extends SocialMediaState {}

final class GetCommentsSuccess extends SocialMediaState {}



final class AddPostLoading extends SocialMediaState {}

final class AddPostSuccess extends SocialMediaState {}

final class AddPostFailure extends SocialMediaState {
  final String errorMessage;

  AddPostFailure({required this.errorMessage});
}


final class UpdatePostLoading extends SocialMediaState {}
final class UpdatePostSuccess extends SocialMediaState {}

final class UpdatePostFailure extends SocialMediaState {
  final String errorMessage;

  UpdatePostFailure({required this.errorMessage});
}

final class DeletePostLoading extends SocialMediaState {}

final class DeletePostFailure extends SocialMediaState {
  final String errorMessage;

  DeletePostFailure({required this.errorMessage});
}

final class DeleteCommentLoading extends SocialMediaState {}

final class DeleteCommentFailure extends SocialMediaState {
  final String errorMessage;

  DeleteCommentFailure({required this.errorMessage});
}

final class AddCommentFailure extends SocialMediaState {
  final String errorMessage;

  AddCommentFailure({required this.errorMessage});
}

final class GetUserPostsLoading extends SocialMediaState {}

final class GetUserPostsPaginationLoading extends SocialMediaState {}

final class GetUserPostsSuccess extends SocialMediaState {}



final class GetUserProfileSuccess extends SocialMediaState {}

final class GetUserProfileLoading extends SocialMediaState {}
final class UpdateCommentSuccess extends SocialMediaState {}


final class UpdateCommentFailure extends SocialMediaState {
  final String errorMessage;

  UpdateCommentFailure({required this.errorMessage});
}


