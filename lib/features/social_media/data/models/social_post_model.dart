import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
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

class SocialPostAdapter extends TypeAdapter<SocialPostModel> {
  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, SocialPostModel obj) {
    writer.writeString(obj.userId);
    writer.writeString(obj.userName);
    writer.writeString(obj.profilePhoto);
    writer.writeBool(obj.isLoved);
    writer.writeBool(obj.isSaved);
    writer.writeInt(obj.postId);
    writer.writeString(obj.content);
    writer.writeStringList(obj.files);
    writer.writeInt(obj.numberOfReacts);
    writer.writeInt(obj.numberOfSaves);
    writer.writeInt(obj.numberofComments);
    writer.write(obj.createdAt.toIso8601String());
    writer.write(obj.updatedAt?.toIso8601String());
  }

  @override
  SocialPostModel read(BinaryReader reader) {
    return SocialPostModel(
      userId: reader.readString(),
      userName: reader.readString(),
      profilePhoto: reader.readString(),
      isLoved: reader.readBool(),
      isSaved: reader.readBool(),
      postId: reader.readInt(),
      content: reader.readString(),
      files: reader.readStringList(),
      numberOfReacts: reader.readInt(),
      numberOfSaves: reader.readInt(),
      numberofComments: reader.readInt(),
      createdAt: DateTime.parse(reader.read()),
      updatedAt: reader.read() != null ? DateTime.parse(reader.read()) : null,
    );
  }
}