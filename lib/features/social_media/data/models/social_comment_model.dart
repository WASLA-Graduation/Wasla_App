import 'package:wasla/core/database/api/api_keys.dart';

class CommentModel {
  final int commentId;
   String content;
  bool isLove;
  int numberOfLikes;
  final String? file;
  final String userName;
  final String userProfile;
  final DateTime createdAt;
  final DateTime? updatedAt;

  final String userId;

  CommentModel({
    required this.userId,
    required this.commentId,
    required this.content,
    required this.isLove,
    required this.numberOfLikes,
    this.file,
    required this.userName,
    required this.userProfile,
    required this.createdAt,
    this.updatedAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      userId: json[ApiKeys.userId] ?? '',
      commentId: json[ApiKeys.commentId] ?? 0,
      content: json[ApiKeys.content] ?? '',
      isLove: json[ApiKeys.isLove] ?? false,
      numberOfLikes: json[ApiKeys.numberOfLikes] ?? 0,
      file: json[ApiKeys.file],
      userName: json[ApiKeys.userName] ?? '',
      userProfile: json[ApiKeys.userProfile] ?? '',
      createdAt: DateTime.parse(json[ApiKeys.createdAt]),
      updatedAt:
          json[ApiKeys.updatedAt] == null ||
              json[ApiKeys.updatedAt] == "0001-01-01T00:00:00"
          ? null
          : DateTime.parse(json[ApiKeys.updatedAt]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.commentId: commentId,
      ApiKeys.content: content,
      ApiKeys.isLove: isLove,
      ApiKeys.numberOfLikes: numberOfLikes,
      ApiKeys.file: file,
      ApiKeys.userName: userName,
      ApiKeys.userProfile: userProfile,
      ApiKeys.createdAt: createdAt.toIso8601String(),
      ApiKeys.updatedAt: updatedAt?.toIso8601String(),
    };
  }
}
