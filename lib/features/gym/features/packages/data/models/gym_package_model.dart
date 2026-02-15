
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';

class GymPackageModel {
  final int id;
  final String serviceProviderId;
  final String nameEn;
  final String nameAr;
  final String descriptionEn;
  final String descriptionAr;
  final double precentage;
  final double price;
  final double newPrice;
  final int durationInMonths;
  final String photoUrl;
  final int type;

  GymPackageModel({
    required this.id,
    required this.serviceProviderId,
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.precentage,
    required this.price,
    required this.newPrice,
    required this.durationInMonths,
    required this.photoUrl,
    required this.type,
  });

  factory GymPackageModel.fromJson(Map<String, dynamic> json) {
    return GymPackageModel(
      id: json[ApiKeys.id],
      serviceProviderId: json[ApiKeys.serviceProviderId],
      nameEn: json[ApiKeys.name][ApiKeys.english],
      nameAr: json[ApiKeys.name][ApiKeys.arabic],
      descriptionEn: json[ApiKeys.descriptionSmall][ApiKeys.english],
      descriptionAr: json[ApiKeys.descriptionSmall][ApiKeys.arabic],
      precentage: json[ApiKeys.precentage],
      price: (json[ApiKeys.price] as num).toDouble(),
      newPrice: (json[ApiKeys.newPrice] as num).toDouble(),
      durationInMonths: json[ApiKeys.durationInMonths],
      photoUrl: ApiEndPoints.imageBaseUrl + json[ApiKeys.photoUrl],
      type: json[ApiKeys.type],
    );
  }
}

