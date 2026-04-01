import 'package:wasla/core/database/api/api_keys.dart';

class AllUsersChatModel {
  final String id;
  final String name;
  final String image;
  final String bio;

  AllUsersChatModel({
    required this.id,
    required this.name,
    required this.image,
    required this.bio,
  });

  factory AllUsersChatModel.fromJson(Map<String, dynamic> json) {
    return AllUsersChatModel(
      id: json[ApiKeys.id] ?? '',
      name: json[ApiKeys.name] ?? '',
      image: json[ApiKeys.imageSmall] ?? '',
      bio: json[ApiKeys.bio] ?? 'Never Give Up',
    );
  }
}
