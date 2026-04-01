import 'package:wasla/core/database/api/api_keys.dart';

class SocialProfileModel {
  final String userName;
  final String profilePhoto;
   int postsCount;
   int reactionsCount;
   int savesCount;

  SocialProfileModel({
    required this.userName,
    required this.profilePhoto,
    required this.postsCount,
    required this.reactionsCount,
    required this.savesCount,
  });

  factory SocialProfileModel.fromJson(Map<String, dynamic> json) {
    return SocialProfileModel(
      userName: json[ApiKeys.userName] ?? "",
      profilePhoto: json[ApiKeys.profilePhoto] ?? "",
      postsCount: json[ApiKeys.postsCount] ?? 0,
      reactionsCount: json[ApiKeys.reactionsCount] ?? 0,
      savesCount: json[ApiKeys.savesCount] ?? 0,
    );
  }
}
