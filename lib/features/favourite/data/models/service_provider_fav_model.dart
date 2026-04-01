import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/enums/service_provider_type.dart';

class ServiceProviderModel {
  final int id;
  final String residentId;
  final String serviceProviderId;
  final String serviceProviderName;
  final String serviceProviderProfilePhoto;
  final String serviceProviderPhone;
  final String serviceProviderType;

  const ServiceProviderModel({
    required this.id,
    required this.residentId,
    required this.serviceProviderId,
    required this.serviceProviderName,
    required this.serviceProviderProfilePhoto,
    required this.serviceProviderPhone,
    required this.serviceProviderType,
  });

  factory ServiceProviderModel.fromJson(Map<String, dynamic> json) {
    return ServiceProviderModel(
      id: json[ApiKeys.id],
      residentId: json[ApiKeys.residentId],
      serviceProviderId: json[ApiKeys.serviceProviderId],
      serviceProviderName: json[ApiKeys.serviceProviderName] ?? '',
      serviceProviderProfilePhoto:
          json[ApiKeys.serviceProviderProfilePhoto] == null
          ? ''
          : serviceProviderImage(
                  serviceProviderType: json[ApiKeys.serviceProviderType],
                ) +
                json[ApiKeys.serviceProviderProfilePhoto],
      serviceProviderPhone: json[ApiKeys.serviceProviderPhone] ?? '',
      serviceProviderType: json[ApiKeys.serviceProviderType],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.id: id,
      ApiKeys.residentId: residentId,
      ApiKeys.serviceProviderId: serviceProviderId,
      ApiKeys.serviceProviderName: serviceProviderName,
      ApiKeys.serviceProviderProfilePhoto: serviceProviderProfilePhoto,
      ApiKeys.serviceProviderPhone: serviceProviderPhone,
      ApiKeys.serviceProviderType: serviceProviderType,
    };
  }
}

String serviceProviderImage({required String serviceProviderType}) {
  switch (ServiceProviderTypeEnum.fromStringToServiceProviderType(
    serviceProviderType,
  )) {
    case ServiceProviderTypeEnum.doctor:
      return ApiEndPoints.imageBaseUrl;
    case ServiceProviderTypeEnum.restaurant:
      // TODO: Handle this case.
      throw UnimplementedError();
    case ServiceProviderTypeEnum.driver:
      // TODO: Handle this case.
      throw UnimplementedError();
    case ServiceProviderTypeEnum.gym:
      return ApiEndPoints.gymBaseUrl;
  }
}
