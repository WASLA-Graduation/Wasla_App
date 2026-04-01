import 'package:wasla/core/database/api/api_keys.dart';

class ServiceHubData {
  final int serviceId;
  final String serviceProviderId;

  ServiceHubData({required this.serviceId, required this.serviceProviderId});

  factory ServiceHubData.fromJson(Map<String, dynamic> json) {
    return ServiceHubData(
      serviceId: json[ApiKeys.serviceId],
      serviceProviderId: json[ApiKeys.serviceProviderId],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.serviceId: serviceId,
      ApiKeys.serviceProviderId: serviceProviderId,
    };
  }
}
