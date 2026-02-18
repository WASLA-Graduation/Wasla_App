import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';

class GymDataModel {
  final String id;
  final String name;
  final String description;
  final int rating;
  final String imageUrl;

  static const String defaultImage =
      "https://images.unsplash.com/photo-1571902943202-507ec2618e8f";

  GymDataModel({
    required this.id,
    required this.name,
    required this.description,
    required this.rating,
    required this.imageUrl,
  });

  factory GymDataModel.fromJson(Map<String, dynamic> json) {
    return GymDataModel(
      id: json[ApiKeys.id] ?? '',
      name: json[ApiKeys.name] ?? 'Unknown Gym',
      description: json[ApiKeys.descriptionSmall] ?? 'No description available',
      rating: json[ApiKeys.rating] ?? 0,
      imageUrl: (json[ApiKeys.imageUrl] == null || json[ApiKeys.imageUrl] == '')
          ? defaultImage
          : ApiEndPoints.gymBaseUrl + json[ApiKeys.imageUrl],
    );
  }
}

class GymPaginationModel {
  final int pageNumber;
  final int pageSize;
  final int totalCount;
  final List<GymDataModel> gyms;

  GymPaginationModel({
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.gyms,
  });

  factory GymPaginationModel.fromJson(Map<String, dynamic> json) {
    return GymPaginationModel(
      pageNumber: json[ApiKeys.pageNumber] ?? 0,
      pageSize: json[ApiKeys.pageSize] ?? 0,
      totalCount: json[ApiKeys.totalCount] ?? 0,
      gyms: (json[ApiKeys.data] as List? ?? [])
          .map((e) => GymDataModel.fromJson(e))
          .toList(),
    );
  }
}
