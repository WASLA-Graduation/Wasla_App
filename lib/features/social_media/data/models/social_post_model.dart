import 'dart:io';

import 'package:wasla/core/database/api/api_keys.dart';

class SocialPostModel {
  String userId;
  String userName;
  String profilePhoto;
  bool isLoved;
  bool isSaved;
  final int postId;
  String content;
  List<String> files;
  int numberOfReacts;
  int numberOfSaves;
  int numberofComments;
  final DateTime createdAt;
  final DateTime? updatedAt;
  List<File> newImages = [];

  SocialPostModel({
    required this.userId,
    required this.userName,
    required this.profilePhoto,
    required this.isLoved,
    required this.isSaved,
    required this.postId,
    required this.content,
    required this.files,
    required this.numberOfReacts,
    required this.numberOfSaves,
    required this.numberofComments,
    required this.createdAt,
    this.updatedAt,
  });

  factory SocialPostModel.fromJson(Map<String, dynamic> json) {
    return SocialPostModel(
      userId: json[ApiKeys.userId] ?? '',
      userName: json[ApiKeys.userName] ?? '',
      profilePhoto: json[ApiKeys.profilePhoto] ?? '',
      isLoved: json[ApiKeys.isLoved] ?? false,
      isSaved: json[ApiKeys.isSaved] ?? false,
      postId: json[ApiKeys.postId] ?? 0,
      content: json[ApiKeys.content] ?? '',
      files: List<String>.from(json[ApiKeys.files] ?? []),
      numberOfReacts: json[ApiKeys.numberOfReacts] ?? 0,
      numberOfSaves: json[ApiKeys.numberOfSaves] ?? 0,
      numberofComments: json[ApiKeys.numberofComments] ?? 0,
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
      ApiKeys.userId: userId,
      ApiKeys.userName: userName,
      ApiKeys.profilePhoto: profilePhoto,
      ApiKeys.isLoved: isLoved,
      ApiKeys.isSaved: isSaved,
      ApiKeys.postId: postId,
      ApiKeys.content: content,
      ApiKeys.files: files,
      ApiKeys.numberOfReacts: numberOfReacts,
      ApiKeys.numberOfSaves: numberOfSaves,
      ApiKeys.createdAt: createdAt.toIso8601String(),
      ApiKeys.updatedAt: updatedAt?.toIso8601String(),
    };
  }
}
