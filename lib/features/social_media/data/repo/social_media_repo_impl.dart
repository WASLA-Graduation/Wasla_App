import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:wasla/core/connection/network_info.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/core/enums/social_enums.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/functions/convert_image_to_json.dart';
import 'package:wasla/core/service/service_locator.dart';

import 'package:wasla/features/social_media/data/models/social_comment_model.dart';
import 'package:wasla/features/social_media/data/models/social_post_model.dart';
import 'package:wasla/features/social_media/data/models/social_profile_model.dart';
import 'package:wasla/features/social_media/data/models/update_post_model.dart';
import 'package:wasla/features/social_media/data/repo/social_media_repo.dart';

class SocialMediaRepoImpl extends SocialMediaRepo {
  final ApiConsumer api;

  SocialMediaRepoImpl({required this.api});

  @override
  Future<Either<String, Null>> addPost({
    required String userId,
    String? content,
    List<File>? images,
  }) async {
    try {
      final formData = FormData.fromMap({
        ApiKeys.content: content,
        ApiKeys.userId: userId,
        ApiKeys.filesDto: images == null
            ? null
            : await convertFilesToMultipart(images),
      });

      await api.post(
        ApiEndPoints.socialAddPost,
        body: formData,

        headers: {"Content-Type": "multipart/form-data"},
      );

      return Right(null);
    } on ServerException catch (error) {
      return Left(error.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Null>> updatePost({
    required int id,
    String? content,
    required UpdatePostModel updatePostImages,
  }) async {
    try {
      final formData = FormData.fromMap({
        ApiKeys.content: content,
        ApiKeys.id: id,
        ApiKeys.existingFilesPost: updatePostImages.oldImages.isEmpty
            ? null
            : updatePostImages.oldImages,
        ApiKeys.newFilesPost: updatePostImages.newImages.isEmpty
            ? null
            : await convertFilesToMultipart(updatePostImages.newImages),
      });

      await api.put(
        "api/Social/Post",
        body: formData,
        headers: {"Content-Type": "multipart/form-data"},
      );

      return Right(null);
    } on ServerException catch (error) {
      return Left(error.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Null>> deletePost({required int postId}) async {
    try {
      await api.delete(
        ApiEndPoints.socialAddPost,
        queryParameters: {ApiKeys.postId: postId},
      );

      return Right(null);
    } on ServerException catch (error) {
      return Left(error.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<Failure, List<SocialPostModel>>> getAllPosts({
    required String currentUserId,
    required int pageNumber,
    required int pageSize,
  }) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }

      final reponse = await api.get(
        ApiEndPoints.socialGetAllPosts,
        queryParameters: {
          ApiKeys.pageSize: pageSize,
          ApiKeys.pageNumber: pageNumber,
          ApiKeys.currentUserId: currentUserId,
        },
      );


      List<SocialPostModel> posts = [];
      for (var post in reponse[ApiKeys.data][ApiKeys.data]) {
        posts.add(SocialPostModel.fromJson(post));
      }
      return Right(posts);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SocialPostModel>>> getPostsOfUser({
    required String currentUserId,
    required String userId,
    required int pageNumber,
    required int pageSize,
  }) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }
      final reponse = await api.get(
        '${ApiEndPoints.socialGetAllPosts}/$userId',
        queryParameters: {
          ApiKeys.pageSize: pageSize,
          ApiKeys.pageNumber: pageNumber,
          ApiKeys.currentUser: currentUserId,
        },
      );

      List<SocialPostModel> posts = [];

      final String userName = reponse[ApiKeys.data][ApiKeys.userName];
      final String userImage = reponse[ApiKeys.data][ApiKeys.profilePhoto];
      for (var post in reponse[ApiKeys.data][ApiKeys.posts][ApiKeys.data]) {
        SocialPostModel myPost = SocialPostModel.fromJson(post);
        myPost.userName = userName;
        myPost.profilePhoto = userImage;
        posts.add(myPost);
      }
      return Right(posts);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<String, Null>> addComment({
    required String userId,
    required String content,
    required int postId,
  }) async {
    try {
      await api.post(
        ApiEndPoints.socialComment,
        queryParameters: {
          ApiKeys.content: content,
          ApiKeys.userId: userId,
          ApiKeys.postId: postId,
        },
      );

      return Right(null);
    } on ServerException catch (error) {
      return Left(error.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Null>> deleteComment({required int commentId}) async {
    try {
      await api.delete(
        ApiEndPoints.socialComment,
        queryParameters: {ApiKeys.commentId: commentId},
      );

      return Right(null);
    } on ServerException catch (error) {
      return Left(error.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Null>> updateComment({
    required String content,
    required int commentId,
  }) async {
    try {
      await api.put(
        'api/Social/Commnet',
        queryParameters: {
          ApiKeys.content: content,
          ApiKeys.commentId: commentId,
        },
        headers: {'Content-Type': 'multipart/form-data'},

        body: FormData(),
      );

      return Right(null);
    } on ServerException catch (error) {
      return Left(error.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<Failure, List<CommentModel>>> getAllPostComments({
    required String currentUserId,
    required int postId,
    required int pageNumber,
    required int pageSize,
  }) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }
      final reponse = await api.get(
        ApiEndPoints.getAllComments,
        queryParameters: {
          ApiKeys.pageSize: pageSize,
          ApiKeys.pageNumber: pageNumber,
          ApiKeys.currentUserId: currentUserId,
          ApiKeys.postId: postId,
        },
      );

      List<CommentModel> comments = [];
      for (var comment in reponse[ApiKeys.data][ApiKeys.data]) {
        comments.add(CommentModel.fromJson(comment));
      }
      return Right(comments);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<String, Null>> toggleReaction({
    required String userId,
    required int targetId,
    required int targetType,
    required int reactionType,
  }) async {
    try {
      await api.post(
        ApiEndPoints.socialToggleRecation,
        body: {
          ApiKeys.targetId: targetId,
          ApiKeys.targetType: targetType,
          ApiKeys.reactionType: reactionType,
          ApiKeys.userId: userId,
        },
      );

      return Right(null);
    } on ServerException catch (error) {
      return Left(error.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<Failure, List<SocialPostModel>>> getPostsOfUserByReactionType({
    required String userId,
    required int reactionType,
    required int pageNumber,
    required int pageSize,
  }) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }
      final reponse = await api.get(
        ApiEndPoints.socialGetPostsByReaction,
        queryParameters: {
          ApiKeys.reactionType: reactionType,
          ApiKeys.pageSize: pageSize,
          ApiKeys.pageNumber: pageNumber,
          ApiKeys.userId: userId,
        },
      );

      List<SocialPostModel> posts = [];
      for (var post in reponse[ApiKeys.data][ApiKeys.data]) {
        posts.add(SocialPostModel.fromJson(post));
      }
      return Right(posts);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SocialProfileModel>> getUserProfile({
    required String userId,
  }) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }

      final reponse = await api.get(
        ApiEndPoints.socialGetUserInfo,
        queryParameters: {ApiKeys.userId: userId},
      );
      return Right(SocialProfileModel.fromJson(reponse[ApiKeys.data]));
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<String, Null>> reportForSomething({
    required String userId,
    required String reason,
    required int targetId,
    required TargetType targetType,
  }) async {
    try {
      await api.post(
        ApiEndPoints.reportForSomething,
        body: {
          ApiKeys.userId: userId,
          ApiKeys.reason: reason,
          ApiKeys.targetId: targetId,
          ApiKeys.targetType: targetType.index + 1,
        },
      );

      return Right(null);
    } on ServerException catch (error) {
      return Left(error.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
