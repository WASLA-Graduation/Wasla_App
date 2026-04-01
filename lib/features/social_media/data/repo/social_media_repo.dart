import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:wasla/features/social_media/data/models/social_comment_model.dart';
import 'package:wasla/features/social_media/data/models/social_post_model.dart';
import 'package:wasla/features/social_media/data/models/social_profile_model.dart';
import 'package:wasla/features/social_media/data/models/update_post_model.dart';

abstract class SocialMediaRepo {
  Future<Either<String, Null>> addPost({
    required String userId,
    String? content,
    List<File>? images,
  });
  Future<Either<String, Null>> updatePost({
    required int id,
    String? content,
    required UpdatePostModel updatePostImages,
  });
  Future<Either<String, Null>> deletePost({required int postId});
  Future<Either<String, List<SocialPostModel>>> getAllPosts({
    required String currentUserId,
    required int pageNumber,
    required int pageSize,
  });
  Future<Either<String, List<SocialPostModel>>> getPostsOfUser({
    required String currentUserId,
    required String userId,
    required int pageNumber,
    required int pageSize,
  });

  Future<Either<String, Null>> addComment({
    required String userId,
    required String content,
    required int postId,
  });
  Future<Either<String, Null>> updateComment({
    required String content,
    required int commentId,
  });
  Future<Either<String, Null>> deleteComment({required int commentId});

  Future<Either<String, List<CommentModel>>> getAllPostComments({
    required String currentUserId,
    required int postId,
    required int pageNumber,
    required int pageSize,
  });
  Future<Either<String, Null>> toggleReaction({
    required String userId,
    required int targetId,
    required int targetType,
    required int reactionType,
  });

  Future<Either<String, List<SocialPostModel>>> getPostsOfUserByReactionType({
    required String userId,
    required int reactionType,
    required int pageNumber,
    required int pageSize,
  });
  Future<Either<String, SocialProfileModel>> getUSerProfile({
    required String userId,
  });
}
